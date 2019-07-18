-------------------------------------------------------------------------------
-- Title      : Clock
-- Project    : 
-------------------------------------------------------------------------------
-- File       : disp_lut.vhd
-- Author     : Daniel Sun  <dcsun88osh@gmail.com>
-- Company    : 
-- Created    : 2016-05-17
-- Last update: 2018-04-22
-- Platform   : 
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: Display controller look up table
-------------------------------------------------------------------------------
-- Copyright (c) 2016 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author      Description
-- 2016-05-17  1.0      dcsun88osh  Created
-------------------------------------------------------------------------------

library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

--library work;
--use work.util_pkg.all;

library UNISIM;
use UNISIM.vcomponents.all;
library UNIMACRO;
use unimacro.Vcomponents.all;


entity disp_lut is
  port (
      rst_n             : in    std_logic;
      clk               : in    std_logic;

      sram_addr         : in    std_logic_vector(9 downto 0);
      sram_we           : in    std_logic;
      sram_datao        : in    std_logic_vector(31 downto 0);
      sram_datai        : out   std_logic_vector(31 downto 0);

      lut_addr          : in    std_logic_vector(11 downto 0);
      lut_data          : out   std_logic_vector(7 downto 0)
      );
end disp_lut;



architecture structure of disp_lut is

    SIGNAL rst             : std_logic;

begin

    rst <= not rst_n;


-- BRAM_TDP_MACRO: True Dual Port RAM
--                 7 Series
-- Xilinx HDL Libraries Guide, version 2014.4
-- Note - This Unimacro model assumes the port directions to be "downto".
--        Simulation of this model with "to" in the port directions could lead to erroneous results.
--------------------------------------------------------------------------
-- DATA_WIDTH_A/B | BRAM_SIZE | RAM Depth | ADDRA/B Width | WEA/B Width --
-- ===============|===========|===========|===============|=============--
--    19-36       |  "36Kb"   |    1024   |    10-bit     |    4-bit    --
--    10-18       |  "36Kb"   |    2048   |    11-bit     |    2-bit    --
--    10-18       |  "18Kb"   |    1024   |    10-bit     |    2-bit    --
--    5-9         |  "36Kb"   |    4096   |    12-bit     |    1-bit    --
--    5-9         |  "18Kb"   |    2048   |    11-bit     |    1-bit    --
--    3-4         |  "36Kb"   |    8192   |    13-bit     |    1-bit    --
--    3-4         |  "18Kb"   |    4096   |    12-bit     |    1-bit    --
--    2           |  "36Kb"   |   16384   |    14-bit     |    1-bit    --
--    2           |  "18Kb"   |    8192   |    13-bit     |    1-bit    --
--    1           |  "36Kb"   |   32768   |    15-bit     |    1-bit    --
--    1           |  "18Kb"   |   16384   |    14-bit     |    1-bit    --
--------------------------------------------------------------------------
BRAM_TDP_MACRO_inst : BRAM_TDP_MACRO
    generic map (
        BRAM_SIZE           => "36Kb", -- Target BRAM, "18Kb" or "36Kb"
        DEVICE              => "7SERIES", -- Target Device: "VIRTEX5", "VIRTEX6", "7SERIES", "SPARTAN6"
        DOA_REG             => 0, -- Optional port A output register (0 or 1)
        DOB_REG             => 0, -- Optional port B output register (0 or 1)
        INIT_A              => X"000000000", -- Initial values on A output port
        INIT_B              => X"000000000", -- Initial values on B output port
        INIT_FILE           => "NONE",
        READ_WIDTH_A        => 32, -- Valid values are 1-36 (19-36 only valid when BRAM_SIZE="36Kb")
        READ_WIDTH_B        => 8, -- Valid values are 1-36 (19-36 only valid when BRAM_SIZE="36Kb")
        SIM_COLLISION_CHECK => "ALL", -- Collision check enable "ALL", "WARNING_ONLY",
-- "GENERATE_X_ONLY" or "NONE"
        SRVAL_A             => X"000000000", -- Set/Reset value for A port output
        SRVAL_B             => X"000000000", -- Set/Reset value for B port output
        WRITE_MODE_A        => "WRITE_FIRST", -- "WRITE_FIRST", "READ_FIRST" or "NO_CHANGE"
        WRITE_MODE_B        => "WRITE_FIRST", -- "WRITE_FIRST", "READ_FIRST" or "NO_CHANGE"
        WRITE_WIDTH_A       => 32, -- Valid values are 1-36 (19-36 only valid when BRAM_SIZE="36Kb")
        WRITE_WIDTH_B       => 8, -- Valid values are 1-36 (19-36 only valid when BRAM_SIZE="36Kb")
        -- The following INIT_xx declarations specify the initial contents of the RAM
        INIT_00 => X"000000000000000000000064006300530075006e00380038002000470050004c",
        INIT_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_02 => X"00220023002400250026002700280029002a002b002c002d002e002f00300031",
        INIT_03 => X"0000000000000000000000000000000000000000000000000000000000200021",
        INIT_04 => X"003400350036003700380039003a003b003c003d003e003f0040004100420043",
        INIT_05 => X"0000000000000000000000000000000000000000000000000000000000320033",
        INIT_06 => X"0046004700480049004a004b004c004d004e004f005000510052005300540055",
        INIT_07 => X"0000000000000000000000000000000000000000000000000000000000440045",
        INIT_08 => X"00580059005a005b005c005d005e005f00600061006200630064006500660067",
        INIT_09 => X"0000000000000000000000000000000000000000000000000000000000560057",
        INIT_0A => X"006a006b006c006d006e006f0070007100720073007400750076007700780079",
        INIT_0B => X"0000000000000000000000000000000000000000000000000000000000680069",
        INIT_0C => X"007c007d007e007f002000200020002000200020002000200020002000200020",
        INIT_0D => X"00000000000000000000000000000000000000000000000000000000007a007b",
        INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_10 => X"0020002000200020002000880087002000860085002000840183008200810080",
        INIT_11 => X"0000000000000000000000000000000000000000000000000000000000200020",
        INIT_12 => X"0020002000200020008800870020008600850020008401830082008100800020",
        INIT_13 => X"0000000000000000000000000000000000000000000000000000000000200020",
        INIT_14 => X"0020002000200088008700200086008500200084018300820081008000200020",
        INIT_15 => X"0000000000000000000000000000000000000000000000000000000000200020",
        INIT_16 => X"0020002000880087002000860085002000840183008200810080002000200020",
        INIT_17 => X"0000000000000000000000000000000000000000000000000000000000200020",
        INIT_18 => X"0020008800870020008600850020008401830082008100800020002000200020",
        INIT_19 => X"0000000000000000000000000000000000000000000000000000000000200020",
        INIT_1A => X"0088008700200086008500200084018300820081008000200020002000200020",
        INIT_1B => X"0000000000000000000000000000000000000000000000000000000000200020",
        INIT_1C => X"0087002000860085002000840183008200810080002000200020002000200020",
        INIT_1D => X"0000000000000000000000000000000000000000000000000000000000200088",
        INIT_1E => X"0020008600850020008401830082008100800020002000200020002000200020",
        INIT_1F => X"0000000000000000000000000000000000000000000000000000000000880087",
        INIT_20 => X"0086008500200084018300820081008000200020002000200020002000200088",
        INIT_21 => X"0000000000000000000000000000000000000000000000000000000000870020",
        INIT_22 => X"0085002000840183008200810080002000200020002000200020002000880087",
        INIT_23 => X"0000000000000000000000000000000000000000000000000000000000200086",
        INIT_24 => X"0020008401830082008100800020002000200020002000200020008800870020",
        INIT_25 => X"0000000000000000000000000000000000000000000000000000000000860085",
        INIT_26 => X"0084018300820081008000200020002000200020002000200088008700200086",
        INIT_27 => X"0000000000000000000000000000000000000000000000000000000000850020",
        INIT_28 => X"0183008200810080002000200020002000200020002000880087002000860085",
        INIT_29 => X"0000000000000000000000000000000000000000000000000000000000200084",
        INIT_2A => X"0082008100800020002000200020002000200020008800870020008600850020",
        INIT_2B => X"0000000000000000000000000000000000000000000000000000000000840183",
        INIT_2C => X"0081008000200020002000200020002000200088008700200086008500200084",
        INIT_2D => X"0000000000000000000000000000000000000000000000000000000001830082",
        INIT_2E => X"0080002000200020002000200020002000880087002000860085002000840183",
        INIT_2F => X"0000000000000000000000000000000000000000000000000000000000820081",
        INIT_30 => X"0020002000200020002000200020008800870020008600850020008401830082",
        INIT_31 => X"0000000000000000000000000000000000000000000000000000000000810080",
        INIT_32 => X"0020002000200020002000200088008700200086008500200084018300820081",
        INIT_33 => X"0000000000000000000000000000000000000000000000000000000000800020",
        INIT_34 => X"002000470050004c002000470050004c002000470050004c002000470050004c",
        INIT_35 => X"002000470050004c002000470050004c002000470050004c002000470050004c",
        INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_38 => X"000000000000000000000064006300530075006e00380038002000470050004c",
        INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_3C => X"0020008800870020008600850020008401830082008100800020002000200020",
        INIT_3D => X"0020002000200020002000200020002000200020002000200020002000200020",
        INIT_3E => X"0138013801380138013801380138013801380138013801380138013801380138",
        INIT_3F => X"0138013801380138013801380138013801380138013801380138013801380138",
        -- The next set of INIT_xx are valid when configured as 36Kb
        INIT_40 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_41 => X"ca0012000000f6fee0beb666f2da60fc00010200000000000400000000440000",
        INIT_42 => X"1000000000da766e547c7c1eb6ccd6cefceca81cae780c6ebc8e9e7a9cfeee00",
        INIT_43 => X"0080000000da766e4438381eb60ae6ce3a2a280cae30082ef68ede7a1a3efa40",
        INIT_44 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_45 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_46 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_47 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_48 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_49 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_4A => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_4B => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_4C => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_4D => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_4E => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_4F => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_50 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_51 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_52 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_53 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_54 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_55 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_56 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_57 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_58 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_59 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_5A => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_5B => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_5C => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_5D => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_5E => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_5F => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_60 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_61 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_62 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_63 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_64 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_65 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_66 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_67 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_68 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_69 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_6A => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_6B => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_6C => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_6D => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_6E => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_6F => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_70 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_71 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_72 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_73 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_74 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_75 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_76 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_77 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_78 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_79 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_7A => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_7B => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_7C => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_7D => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_7E => X"0000000000000000000000000000000000000000000000000000000000000000",
        INIT_7F => X"0000000000000000000000000000000000000000000000000000000000000000",
        -- The next set of INITP_xx are for the parity bits
        INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
        -- The next set of INIT_xx are valid when configured as 36Kb
        INITP_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INITP_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
        INITP_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
        INITP_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
        INITP_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
        INITP_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
        INITP_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
        INITP_0F => X"0000000000000000000000000000000000000000000000000000000000000000")
    port map (
        DOA    => sram_datai,  -- Output port-A data, width defined by READ_WIDTH_A parameter
        DOB    => lut_data,  -- Output port-B data, width defined by READ_WIDTH_B parameter
        ADDRA  => sram_addr,  -- Input port-A address, width defined by Port A depth
        ADDRB  => lut_addr,  -- Input port-B address, width defined by Port B depth
        CLKA   => clk,                  -- 1-bit input port-A clock
        CLKB   => clk,                  -- 1-bit input port-B clock
        DIA    => sram_datao,  -- Input port-A data, width defined by WRITE_WIDTH_A parameter
        DIB    => x"00",  -- Input port-B data, width defined by WRITE_WIDTH_B parameter
        ENA    => '1',   -- 1-bit input port-A enable
        ENB    => '1',   -- 1-bit input port-B enable
        REGCEA => '1',   -- 1-bit input port-A output register enable
        REGCEB => '1',   -- 1-bit input port-B output register enable
        RSTA   => rst,   -- 1-bit input port-A reset
        RSTB   => rst,     -- 1-bit input port-B reset
        WEA(0) => sram_we,  -- Input port-A write enable, width defined by Port A depth
        WEA(1) => sram_we,  -- Input port-A write enable, width defined by Port A depth
        WEA(2) => sram_we,  -- Input port-A write enable, width defined by Port A depth
        WEA(3) => sram_we,  -- Input port-A write enable, width defined by Port A depth
        WEB    => "0"  -- Input port-B write enable, width defined by Port B depth
        );
-- End of BRAM_TDP_MACRO_inst instantiation


end structure;
