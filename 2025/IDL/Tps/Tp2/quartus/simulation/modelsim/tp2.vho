-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"

-- DATE "06/13/2025 18:21:06"

-- 
-- Device: Altera EP4CGX15BF14C6 Package FBGA169
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEIV;
LIBRARY IEEE;
USE CYCLONEIV.CYCLONEIV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	tp2 IS
    PORT (
	B8 : OUT std_logic;
	pin_name1 : IN std_logic;
	B7 : OUT std_logic;
	B6 : OUT std_logic;
	B5 : OUT std_logic;
	B4 : OUT std_logic;
	B3 : OUT std_logic;
	B2 : OUT std_logic;
	B1 : OUT std_logic;
	B0 : OUT std_logic
	);
END tp2;

-- Design Ports Information
-- B8	=>  Location: PIN_G10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pin_name1	=>  Location: PIN_D13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B7	=>  Location: PIN_L12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B6	=>  Location: PIN_M11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B5	=>  Location: PIN_A8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B4	=>  Location: PIN_J13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B3	=>  Location: PIN_N11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B2	=>  Location: PIN_A13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B1	=>  Location: PIN_L13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B0	=>  Location: PIN_H10,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF tp2 IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_B8 : std_logic;
SIGNAL ww_pin_name1 : std_logic;
SIGNAL ww_B7 : std_logic;
SIGNAL ww_B6 : std_logic;
SIGNAL ww_B5 : std_logic;
SIGNAL ww_B4 : std_logic;
SIGNAL ww_B3 : std_logic;
SIGNAL ww_B2 : std_logic;
SIGNAL ww_B1 : std_logic;
SIGNAL ww_B0 : std_logic;
SIGNAL \pin_name1~input_o\ : std_logic;
SIGNAL \B8~output_o\ : std_logic;
SIGNAL \B7~output_o\ : std_logic;
SIGNAL \B6~output_o\ : std_logic;
SIGNAL \B5~output_o\ : std_logic;
SIGNAL \B4~output_o\ : std_logic;
SIGNAL \B3~output_o\ : std_logic;
SIGNAL \B2~output_o\ : std_logic;
SIGNAL \B1~output_o\ : std_logic;
SIGNAL \B0~output_o\ : std_logic;

BEGIN

B8 <= ww_B8;
ww_pin_name1 <= pin_name1;
B7 <= ww_B7;
B6 <= ww_B6;
B5 <= ww_B5;
B4 <= ww_B4;
B3 <= ww_B3;
B2 <= ww_B2;
B1 <= ww_B1;
B0 <= ww_B0;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: IOOBUF_X33_Y22_N9
\B8~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \B8~output_o\);

-- Location: IOOBUF_X33_Y12_N2
\B7~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \B7~output_o\);

-- Location: IOOBUF_X29_Y0_N9
\B6~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \B6~output_o\);

-- Location: IOOBUF_X12_Y31_N9
\B5~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \B5~output_o\);

-- Location: IOOBUF_X33_Y15_N9
\B4~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \B4~output_o\);

-- Location: IOOBUF_X26_Y0_N2
\B3~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \B3~output_o\);

-- Location: IOOBUF_X26_Y31_N2
\B2~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \B2~output_o\);

-- Location: IOOBUF_X33_Y12_N9
\B1~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \B1~output_o\);

-- Location: IOOBUF_X33_Y14_N2
\B0~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \B0~output_o\);

-- Location: IOIBUF_X29_Y31_N8
\pin_name1~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_pin_name1,
	o => \pin_name1~input_o\);

ww_B8 <= \B8~output_o\;

ww_B7 <= \B7~output_o\;

ww_B6 <= \B6~output_o\;

ww_B5 <= \B5~output_o\;

ww_B4 <= \B4~output_o\;

ww_B3 <= \B3~output_o\;

ww_B2 <= \B2~output_o\;

ww_B1 <= \B1~output_o\;

ww_B0 <= \B0~output_o\;
END structure;


