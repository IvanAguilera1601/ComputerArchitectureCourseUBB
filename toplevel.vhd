----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:21:02 10/22/2018 
-- Design Name: 
-- Module Name:    toplevel - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all; use IEEE.STD_LOGIC_UNSIGNED.all;
	entity top is 					-- se señalan los puertos de entrada y salida
	port (clk, reset:				 in		 STD_LOGIC;
			writedata, dataadr: 	 buffer STD_LOGIC_VECTOR (31 downto 0);
			memwrite: 				 buffer STD_LOGIC);
end;
architecture test of top is	-- se nombran las señales internas de la oveja asi como su funcionamiento
	component mips
		port (clk, reset: 		 in STD_LOGIC;
				pc: 					 out STD_LOGIC_VECTOR (31 downto 0);
				instr: 				 in STD_LOGIC_VECTOR (31 downto 0);
				memwrite: 			 out STD_LOGIC;
				aluout, writedata: out STD_LOGIC_VECTOR (31 downto 0);
				readdata: 			 in STD_LOGIC_VECTOR (31 downto 0));
end component;
	component imem
		port (a: 				 	 in STD_LOGIC_VECTOR (5 downto 0)
				rd: 					 out STD_LOGIC_VECTOR (31 downto 0));
end component;
component dmem
	port (clk, we: 				 in STD_LOGIC;
			a, wd: 					 in STD_LOGIC_VECTOR (31 downto 0);
			rd: 						 out STD_LOGIC_VECTOR (31 downto 0));
end component;
signal pc, instr,
			readdata: 				 STD_LOGIC_VECTOR (31 downto 0);
begin
-- instanciar procesador y memorias
	mips1: mips port map (clk, reset, pc, instr, memwrite,
			 dataadr, writedata, readdata);
	imem1: imem port map (pc (7 downto 2), instr);
	dmem1: dmem port map (clk, memwrite, dataadr, writedata,
	readdata);
end;