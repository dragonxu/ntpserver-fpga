-------------------------------------------------------------------------------
-- Title      : CLock
-- Project    :
-------------------------------------------------------------------------------
-- File       : regs.vhd
-- Author     : Daniel Sun  <dcsun88osh@gmail.com>
-- Company    :
-- Created    : 2016-03-13
-- Last update: 2016-08-23
-- Platform   :
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: Register interface to the EPC bus
-------------------------------------------------------------------------------
-- Copyright (c) 2016
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author      Description
-- 2016-03-13  1.0      dcsun88osh  Created
-------------------------------------------------------------------------------
--
--              Address range: 0x8060_0000 - 0x8060_FFFF
--             | 3 |         2         |         1         |         0         |
--             |1|0|9|8|7|6|5|4|3|2|1|0|9|8|7|6|5|4|3|2|1|0|9|8|7|6|5|4|3|2|1|0|
--
-- 0x8060_0000 |                            TSC LSB                            |
--
-- 0x8060_0004 |                            TSC MSB                            |
--
-- 0x8060_0008 |                     TSC LSB @ last second                     |
--
-- 0x8060_000c |                     TSC MSB @ last second                     |
--
-- 0x8060_0010 |                        1PPS Phase Error                       |
--
-- 0x8060_0014 |                        1PPS Frequency Error                   |
--
-- 0x8060_0018 |                         GPS 1PPS Copunt                       |
--
-- 0x8060_001c | 10 h  | 1 h   | 10 m  |  1 m  | 10 s  |  1 s  | 100 ms| 10 ms |
--
-- 0x8060_0020 |               | 10 h  | 1 h   | 10 m  |  1 m  | 10 s  |  1 s  |
--
-- 0x8060_0024 | |                   | |       |            DAC value          |
--              |                     |
--              GPS 3D Fix            Sync PFD and PLL
--
--
-- 0x8060_0100 |             uSPR                      |       |    Fan pwm    |
--
--
-- 0x8060_0200 |                                               |    disp pdm   |
--
-- 0x8060_0204 |      Decimal point      ...    f e d c b a 9 8 7 6 5 4 3 2 1 0|
--
--
-- 0x8060_1000 |    digit 3    |    digit 2    |    digit 1    |    digit 0    |
--
-- 0x8060_1004 |    digit 7    |    digit 6    |    digit 5    |    digit 4    |
--
-- 0x8060_1008 |    digit 11   |    digit 10   |    digit 9    |    digit 8    |
--
-- 0x8060_100c |    digit 15   |    digit 14   |    digit 13   |    digit 12   |
--
-- 0x8060_1010 |    digit 19   |    digit 18   |    digit 17   |    digit 16   |
--
-- 0x8060_1014 |    digit 23   |    digit 22   |    digit 21   |    digit 20   |
--
-- 0x8060_1018 |    digit 27   |    digit 26   |    digit 25   |    digit 24   |
--
-- 0x8060_101c |    digit 31   |    digit 30   |    digit 29   |    digit 28   |
--
-- 0x8060_1020 |                              RAM                              |
-- 0x8060_17FC |                              RAM                              |
--
-- 0x8060_1800 |     lut  3    |     lut  2    |     lut  1    |     lut  0    |
--
-- 0x8060_1804 |     lut  7    |     lut  6    |     lut  5    |     lut  4    |
--
-- 0x8060_1808 |     lut  11   |     lut  10   |     lut  9    |     lut  8    |
--
-- 0x8060_180c |     lut  15   |     lut  14   |     lut  13   |     lut  12   |
--
-- 0x8060_1810 |     lut  19   |     lut  18   |     lut  17   |     lut  16   |
--
--
-- 0x8060_187C |     lut 127   |     lut 126   |     lut 125   |     lut 124   |
--
-- 0x8060_1880 |                              RAM                              |
-- 0x8060_1FFC |                              RAM                              |
--


library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

use work.types_pkg.all;

entity regs is
    port (
        rst_n             : in    std_logic;
        clk               : in    std_logic;

        EPC_INTF_addr     : in    std_logic_vector(0 to 31);
        EPC_INTF_be       : in    std_logic_vector(0 to 3);
        EPC_INTF_burst    : in    std_logic;
        EPC_INTF_cs_n     : in    std_logic;
        EPC_INTF_data_i   : out   std_logic_vector(0 to 31);
        EPC_INTF_data_o   : in    std_logic_vector(0 to 31);
        EPC_INTF_rdy      : out   std_logic;
        EPC_INTF_rnw      : in    std_logic;  -- Write when '0'

        -- Time stamp counter
        tsc_cnt           : in    std_logic_vector(63 downto 0);
        tsc_cnt1          : in    std_logic_vector(63 downto 0);
        tsc_read          : out   std_logic;

        -- Time setting
        cur_time          : in    time_ty;
        set               : out   std_logic;
        set_time          : out   time_ty;

        -- PLL control
        gps_3dfix_d       : in    std_logic;
        gps_1pps_d        : in    std_logic;
        pdiff_1pps        : in    std_logic_vector(31 downto 0);
        fdiff_1pps        : in    std_logic_vector(31 downto 0);
        tsc_sync          : out   std_logic;
        dac_val           : out   std_logic_vector(15 downto 0);

        -- Fan ms per revolution, percent speed
        fan_uspr          : in    std_logic_vector(19 downto 0);
        fan_pct           : out   std_logic_vector(7 downto 0);

        -- Display memory
        sram_addr         : out   std_logic_vector(9 downto 0);
        sram_we           : out   std_logic;
        sram_datao        : out   std_logic_vector(31 downto 0);
        sram_datai        : in    std_logic_vector(31 downto 0);

        dp                : out   std_logic_vector(31 downto 0);
        disp_pdm          : out   std_logic_vector(7 downto 0)
        );
end regs;



architecture rtl of regs is

    type reg_arr is array (natural range <>) of std_logic_vector(31 downto 0);

    signal time_regs      : reg_arr(9 downto 0);
    signal fan_regs       : reg_arr(0 downto 0);
    signal disp_regs      : reg_arr(1 downto 0);

    signal addr           : std_logic_vector(31 downto 0);
    signal be             : std_logic_vector(3 downto 0);
    signal data_i         : std_logic_vector(31 downto 0);
    signal data_o         : std_logic_vector(31 downto 0);

    signal cs_n_d         : std_logic;
    signal cs_dp_r        : std_logic;
    signal cs_dp_w        : std_logic;
    signal rnw            : std_logic;
    signal rdy_d          : std_logic_vector(2 downto 0);

    signal decode         : std_logic_vector(3 downto 0);
    signal sram           : std_logic;

    SIGNAL gps_1pps_cnt   : std_logic_vector(31 downto 0);

    signal time_regs_mux  : std_logic_vector(31 downto 0);
    signal fan_regs_mux   : std_logic_vector(31 downto 0);
    signal disp_regs_mux  : std_logic_vector(31 downto 0);
    signal sram_regs_mux  : std_logic_vector(31 downto 0);

begin

    -- Big endian to little endian
    addr            <= EPC_INTF_addr;
    be              <= EPC_INTF_be;
    data_o          <= EPC_INTF_data_o;
    -- Little endian to big endian
    EPC_INTF_data_i <= data_i;


    -- Chip select falling edge detect
    process (rst_n, clk) is
    begin
        if (rst_n = '0') then
            rnw     <= '0';
            cs_n_d  <= '1';
            cs_dp_r <= '0';
            cs_dp_w <= '0';
            decode  <= (others => '0');
            sram    <= '0';
        elsif (clk'event and clk = '1') then
            rnw       <= not EPC_INTF_rnw;
            cs_n_d    <= EPC_INTF_cs_n;
            cs_dp_r   <= not EPC_INTF_cs_n and cs_n_d and     EPC_INTF_rnw;
            cs_dp_w   <= not EPC_INTF_cs_n and cs_n_d and not EPC_INTF_rnw;

            -- First level decode
            if (EPC_INTF_cs_n = '0') then
                if (addr(12) = '1') then
                    decode <= (others => '0');
                    sram   <= '1';
                else
                    decode(conv_integer(addr(9 downto 8))) <= '1';
                    sram   <= '0';
                end if;
            else
                decode <= (others => '0');
                sram   <= '0';
            end if;
        end if;
    end process;


    -- Ready signal generator, 3 cycles after delayed chip select
    -- Hold ready active until the chip select goes inactive
    process (rst_n, clk) is
    begin
        if (rst_n = '0') then
            rdy_d        <= (others => '1');
            EPC_INTF_rdy <= '0';
        elsif (clk'event and clk = '1') then
            rdy_d(0)     <= cs_dp_r or cs_dp_w;
            rdy_d(1)     <= rdy_d(0);
            rdy_d(2)     <= rdy_d(1);
            if (EPC_INTF_cs_n = '1') then
                EPC_INTF_rdy <= '0';
            elsif (rdy_d(2) = '1') then
                EPC_INTF_rdy <= '1';
            end if;
        end if;
    end process;


    -- Top decode read mux
    process (rst_n, clk) is
    begin
        if (rst_n = '0') then
            data_i <= (others => '0');
        elsif (clk'event and clk = '1') then
            if (sram = '1') then
                data_i <= sram_regs_mux;
            elsif (decode(0) = '1') then
                data_i <= time_regs_mux;
            elsif (decode(1) = '1') then
                data_i <= fan_regs_mux;
            elsif (decode(2) = '1') then
                data_i <= disp_regs_mux;
            end if;
        end if;
    end process;


    -- Read Mux
    process (rst_n, clk) is
    begin
        if (rst_n = '0') then
            time_regs_mux <= (others => '0');
            fan_regs_mux  <= (others => '0');
            disp_regs_mux <= (others => '0');
            sram_regs_mux <= (others => '0');
            tsc_read      <= '0';
        elsif (clk'event and clk = '1') then
            if (cs_n_d = '0') then
                sram_regs_mux <= sram_datai;
                case addr(5 downto 2) is
                    when "0000" =>
                        time_regs_mux <= tsc_cnt(31 downto 0);
                        fan_regs_mux  <= fan_regs(0);
                        fan_regs_mux(31 downto 12) <= fan_uspr;
                        disp_regs_mux <= disp_regs(0);
                    when "0001" =>
                        time_regs_mux <= tsc_cnt(63 downto 32);
                        fan_regs_mux  <= (others => '0');
                        disp_regs_mux <= disp_regs(1);
                    when "0010" =>
                        time_regs_mux <= tsc_cnt1(31 downto 0);
                        fan_regs_mux  <= (others => '0');
                        disp_regs_mux <= (others => '0');
                    when "0011" =>
                        time_regs_mux <= tsc_cnt1(63 downto 32);
                        fan_regs_mux  <= (others => '0');
                        disp_regs_mux <= (others => '0');
                    when "0100" =>
                        time_regs_mux <= pdiff_1pps;
                        fan_regs_mux  <= (others => '0');
                        disp_regs_mux <= (others => '0');
                    when "0101" =>
                        time_regs_mux <= fdiff_1pps;
                        fan_regs_mux  <= (others => '0');
                        disp_regs_mux <= (others => '0');
                    when "0110" =>
                        time_regs_mux <= gps_1pps_cnt;
                        fan_regs_mux  <= (others => '0');
                        disp_regs_mux <= (others => '0');
                    when "0111" =>
                        time_regs_mux <= cur_time.t_10h   & cur_time.t_1h   & 
                                         cur_time.t_10m   & cur_time.t_1m   &
                                         cur_time.t_10s   & cur_time.t_1s   &
                                         cur_time.t_100ms & cur_time.t_10ms;
                        fan_regs_mux  <= (others => '0');
                        disp_regs_mux <= (others => '0');
                    when "1000" =>
                        time_regs_mux <= time_regs(8);
                        fan_regs_mux  <= (others => '0');
                        disp_regs_mux <= (others => '0');
                    when "1001" =>
                        time_regs_mux <= time_regs(9);
                        time_regs_mux(31) <= gps_3dfix_d;
                        fan_regs_mux  <= (others => '0');
                        disp_regs_mux <= (others => '0');
                    when others =>
                        time_regs_mux <= (others => '0');
                        fan_regs_mux  <= (others => '0');
                        disp_regs_mux <= (others => '0');
                end case;
            end if;

            -- Hold tsc value on LSW read
            if (cs_dp_r = '1' and decode(0) = '1' and addr(5 downto 2) = "0000") then
                tsc_read      <= '1';
            else
                tsc_read      <= '0';
            end if;

        end if;
    end process;


    -- time control registers
    process (rst_n, clk) is
    begin
        if (rst_n = '0') then
            for i in time_regs'range loop
                time_regs(i) <= (others => '0');
            end loop;
            set      <= '0';
            time_regs(9)(15 downto 0) <= x"8000";
        elsif (clk'event and clk = '1') then
            if (cs_dp_w = '1' and decode(0) = '1') then
                case addr(5 downto 2) is
                    when "0000" =>
                        time_regs(0) <= data_o;
                    when "0001" =>
                        time_regs(1) <= data_o;
                    when "0010" =>
                        time_regs(2) <= data_o;
                    when "0011" =>
                        time_regs(3) <= data_o;
                    when "0100" =>
                        time_regs(4) <= data_o;
                    when "0101" =>
                        time_regs(5) <= data_o;
                    when "0110" =>
                        time_regs(6) <= data_o;
                    when "0111" =>
                        time_regs(7) <= data_o;
                    when "1000" =>
                        time_regs(8) <= data_o;
                    when "1001" =>
                        time_regs(9) <= data_o;
                    when others =>
                        null;
                end case;
            end if;

            -- Trigger time set
            if (cs_dp_w = '1' and decode(0) = '1' and addr(5 downto 2) = "1000") then
                set          <= '1';
            else
                set          <= '0';
            end if;

            -- Clear the sync flag after its done
            if (gps_1pps_d = '1' and time_regs(9)(20) = '1') then
                time_regs(9)(20) <= '0';
            end if;
        end if;
    end process;

    set_time.t_1ms   <= (others => '0');
    set_time.t_10ms  <= (others => '0');
    set_time.t_100ms <= (others => '0');
    set_time.t_1s    <= time_regs(8)(3 downto 0);
    set_time.t_10s   <= time_regs(8)(7 downto 4);
    set_time.t_1m    <= time_regs(8)(11 downto 8);
    set_time.t_10m   <= time_regs(8)(15 downto 12);
    set_time.t_1h    <= time_regs(8)(19 downto 16);
    set_time.t_10h   <= time_regs(8)(23 downto 20);

    dac_val  <= time_regs(9)(15 downto 0);
    tsc_sync <= time_regs(9)(20);


    -- Fan control registers
    process (rst_n, clk) is
    begin
        if (rst_n = '0') then
            for i in 0 to 0 loop
                fan_regs(i) <= (others => '0');
            end loop;
            fan_regs(0)(7 downto 0) <= x"ff";
        elsif (clk'event and clk = '1') then
            if (cs_dp_w = '1' and decode(1) = '1') then
                case addr(5 downto 2) is
                    when "0000" =>
                        fan_regs(0) <= data_o;
                    when others =>
                        null;
                end case;
            end if;
        end if;
    end process;

    fan_pct <= fan_regs(0)(7 downto 0);


    -- disp control registers
    process (rst_n, clk) is
    begin
        if (rst_n = '0') then
            for i in 0 to 1 loop
                disp_regs(i) <= (others => '0');
            end loop;
            disp_regs(0)(7 downto 0) <= x"ff";
            sram_addr  <= (others => '0');
            sram_we    <= '0';
            sram_datao <= (others => '0');
        elsif (clk'event and clk = '1') then
            if (cs_dp_w = '1' and decode(2) = '1') then
                case addr(5 downto 2) is
                    when "0000" =>
                        disp_regs(0) <= data_o;
                    when "0001" =>
                        disp_regs(1) <= data_o;
                    when others =>
                        null;
                end case;
            end if;
            sram_addr  <= addr(11 downto 2);
            sram_we    <= sram and cs_dp_w;
            sram_datao <= data_o;
        end if;
    end process;

    disp_pdm <= disp_regs(0)(7 downto 0);
    dp       <= disp_regs(1);


    -- GPS 1pps count register
    process (rst_n, clk) is
    begin
        if (rst_n = '0') then
            gps_1pps_cnt <= (others => '0');
        elsif (clk'event and clk = '1') then
            if (gps_1pps_d = '1') then
                gps_1pps_cnt <= gps_1pps_cnt + 1;
            end if;
        end if;
    end process;


end rtl;
