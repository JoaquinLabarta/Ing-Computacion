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

-- DATE "07/17/2025 11:10:39"

-- 
-- Device: Altera EP4CGX15BF14C6 Package FBGA169
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIV.CYCLONEIV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	Integrador IS
    PORT (
	REG : OUT std_logic_vector(11 DOWNTO 0);
	CLK : IN std_logic;
	DATA : IN std_logic_vector(11 DOWNTO 0)
	);
END Integrador;

-- Design Ports Information
-- REG[11]	=>  Location: PIN_L4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- REG[10]	=>  Location: PIN_F10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- REG[9]	=>  Location: PIN_B11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- REG[8]	=>  Location: PIN_A11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- REG[7]	=>  Location: PIN_J13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- REG[6]	=>  Location: PIN_D12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- REG[5]	=>  Location: PIN_C13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- REG[4]	=>  Location: PIN_B13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- REG[3]	=>  Location: PIN_G9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- REG[2]	=>  Location: PIN_A12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- REG[1]	=>  Location: PIN_C12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- REG[0]	=>  Location: PIN_C6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DATA[11]	=>  Location: PIN_M4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLK	=>  Location: PIN_J7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DATA[10]	=>  Location: PIN_F11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DATA[9]	=>  Location: PIN_B10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DATA[8]	=>  Location: PIN_B8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DATA[7]	=>  Location: PIN_K13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DATA[6]	=>  Location: PIN_E10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DATA[5]	=>  Location: PIN_D13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DATA[4]	=>  Location: PIN_A13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DATA[3]	=>  Location: PIN_G10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DATA[2]	=>  Location: PIN_C8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DATA[1]	=>  Location: PIN_C11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DATA[0]	=>  Location: PIN_A9,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF Integrador IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_REG : std_logic_vector(11 DOWNTO 0);
SIGNAL ww_CLK : std_logic;
SIGNAL ww_DATA : std_logic_vector(11 DOWNTO 0);
SIGNAL \CLK~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \REG[11]~output_o\ : std_logic;
SIGNAL \REG[10]~output_o\ : std_logic;
SIGNAL \REG[9]~output_o\ : std_logic;
SIGNAL \REG[8]~output_o\ : std_logic;
SIGNAL \REG[7]~output_o\ : std_logic;
SIGNAL \REG[6]~output_o\ : std_logic;
SIGNAL \REG[5]~output_o\ : std_logic;
SIGNAL \REG[4]~output_o\ : std_logic;
SIGNAL \REG[3]~output_o\ : std_logic;
SIGNAL \REG[2]~output_o\ : std_logic;
SIGNAL \REG[1]~output_o\ : std_logic;
SIGNAL \REG[0]~output_o\ : std_logic;
SIGNAL \CLK~input_o\ : std_logic;
SIGNAL \CLK~inputclkctrl_outclk\ : std_logic;
SIGNAL \DATA[11]~input_o\ : std_logic;
SIGNAL \inst|inst11~feeder_combout\ : std_logic;
SIGNAL \inst|inst11~q\ : std_logic;
SIGNAL \DATA[10]~input_o\ : std_logic;
SIGNAL \inst|inst2~feeder_combout\ : std_logic;
SIGNAL \inst|inst2~q\ : std_logic;
SIGNAL \DATA[9]~input_o\ : std_logic;
SIGNAL \inst|inst12~feeder_combout\ : std_logic;
SIGNAL \inst|inst12~q\ : std_logic;
SIGNAL \DATA[8]~input_o\ : std_logic;
SIGNAL \inst|inst13~feeder_combout\ : std_logic;
SIGNAL \inst|inst13~q\ : std_logic;
SIGNAL \DATA[7]~input_o\ : std_logic;
SIGNAL \inst|inst14~q\ : std_logic;
SIGNAL \DATA[6]~input_o\ : std_logic;
SIGNAL \inst|inst15~q\ : std_logic;
SIGNAL \DATA[5]~input_o\ : std_logic;
SIGNAL \inst|inst16~q\ : std_logic;
SIGNAL \DATA[4]~input_o\ : std_logic;
SIGNAL \inst|inst17~q\ : std_logic;
SIGNAL \DATA[3]~input_o\ : std_logic;
SIGNAL \inst|inst~feeder_combout\ : std_logic;
SIGNAL \inst|inst~q\ : std_logic;
SIGNAL \DATA[2]~input_o\ : std_logic;
SIGNAL \inst|inst1~feeder_combout\ : std_logic;
SIGNAL \inst|inst1~q\ : std_logic;
SIGNAL \DATA[1]~input_o\ : std_logic;
SIGNAL \inst|inst5~feeder_combout\ : std_logic;
SIGNAL \inst|inst5~q\ : std_logic;
SIGNAL \DATA[0]~input_o\ : std_logic;
SIGNAL \inst|inst6~feeder_combout\ : std_logic;
SIGNAL \inst|inst6~q\ : std_logic;

BEGIN

REG <= ww_REG;
ww_CLK <= CLK;
ww_DATA <= DATA;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\CLK~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \CLK~input_o\);

-- Location: IOOBUF_X8_Y0_N9
\REG[11]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|inst11~q\,
	devoe => ww_devoe,
	o => \REG[11]~output_o\);

-- Location: IOOBUF_X33_Y24_N2
\REG[10]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|inst2~q\,
	devoe => ww_devoe,
	o => \REG[10]~output_o\);

-- Location: IOOBUF_X24_Y31_N2
\REG[9]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|inst12~q\,
	devoe => ww_devoe,
	o => \REG[9]~output_o\);

-- Location: IOOBUF_X20_Y31_N2
\REG[8]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|inst13~q\,
	devoe => ww_devoe,
	o => \REG[8]~output_o\);

-- Location: IOOBUF_X33_Y15_N9
\REG[7]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|inst14~q\,
	devoe => ww_devoe,
	o => \REG[7]~output_o\);

-- Location: IOOBUF_X33_Y28_N9
\REG[6]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|inst15~q\,
	devoe => ww_devoe,
	o => \REG[6]~output_o\);

-- Location: IOOBUF_X29_Y31_N2
\REG[5]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|inst16~q\,
	devoe => ww_devoe,
	o => \REG[5]~output_o\);

-- Location: IOOBUF_X26_Y31_N9
\REG[4]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|inst17~q\,
	devoe => ww_devoe,
	o => \REG[4]~output_o\);

-- Location: IOOBUF_X33_Y22_N2
\REG[3]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|inst~q\,
	devoe => ww_devoe,
	o => \REG[3]~output_o\);

-- Location: IOOBUF_X20_Y31_N9
\REG[2]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|inst1~q\,
	devoe => ww_devoe,
	o => \REG[2]~output_o\);

-- Location: IOOBUF_X31_Y31_N9
\REG[1]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|inst5~q\,
	devoe => ww_devoe,
	o => \REG[1]~output_o\);

-- Location: IOOBUF_X14_Y31_N2
\REG[0]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|inst6~q\,
	devoe => ww_devoe,
	o => \REG[0]~output_o\);

-- Location: IOIBUF_X16_Y0_N15
\CLK~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLK,
	o => \CLK~input_o\);

-- Location: CLKCTRL_G17
\CLK~inputclkctrl\ : cycloneiv_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \CLK~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \CLK~inputclkctrl_outclk\);

-- Location: IOIBUF_X8_Y0_N1
\DATA[11]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_DATA(11),
	o => \DATA[11]~input_o\);

-- Location: LCCOMB_X9_Y1_N24
\inst|inst11~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|inst11~feeder_combout\ = \DATA[11]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \DATA[11]~input_o\,
	combout => \inst|inst11~feeder_combout\);

-- Location: FF_X9_Y1_N25
\inst|inst11\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst|inst11~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|inst11~q\);

-- Location: IOIBUF_X33_Y24_N8
\DATA[10]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_DATA(10),
	o => \DATA[10]~input_o\);

-- Location: LCCOMB_X32_Y24_N8
\inst|inst2~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|inst2~feeder_combout\ = \DATA[10]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \DATA[10]~input_o\,
	combout => \inst|inst2~feeder_combout\);

-- Location: FF_X32_Y24_N9
\inst|inst2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst|inst2~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|inst2~q\);

-- Location: IOIBUF_X24_Y31_N8
\DATA[9]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_DATA(9),
	o => \DATA[9]~input_o\);

-- Location: LCCOMB_X24_Y30_N0
\inst|inst12~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|inst12~feeder_combout\ = \DATA[9]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \DATA[9]~input_o\,
	combout => \inst|inst12~feeder_combout\);

-- Location: FF_X24_Y30_N1
\inst|inst12\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst|inst12~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|inst12~q\);

-- Location: IOIBUF_X22_Y31_N1
\DATA[8]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_DATA(8),
	o => \DATA[8]~input_o\);

-- Location: LCCOMB_X23_Y30_N0
\inst|inst13~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|inst13~feeder_combout\ = \DATA[8]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \DATA[8]~input_o\,
	combout => \inst|inst13~feeder_combout\);

-- Location: FF_X23_Y30_N1
\inst|inst13\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst|inst13~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|inst13~q\);

-- Location: IOIBUF_X33_Y15_N1
\DATA[7]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_DATA(7),
	o => \DATA[7]~input_o\);

-- Location: FF_X32_Y16_N9
\inst|inst14\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \DATA[7]~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|inst14~q\);

-- Location: IOIBUF_X33_Y27_N1
\DATA[6]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_DATA(6),
	o => \DATA[6]~input_o\);

-- Location: FF_X32_Y30_N9
\inst|inst15\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \DATA[6]~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|inst15~q\);

-- Location: IOIBUF_X29_Y31_N8
\DATA[5]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_DATA(5),
	o => \DATA[5]~input_o\);

-- Location: FF_X30_Y30_N25
\inst|inst16\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \DATA[5]~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|inst16~q\);

-- Location: IOIBUF_X26_Y31_N1
\DATA[4]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_DATA(4),
	o => \DATA[4]~input_o\);

-- Location: FF_X29_Y30_N9
\inst|inst17\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \DATA[4]~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|inst17~q\);

-- Location: IOIBUF_X33_Y22_N8
\DATA[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_DATA(3),
	o => \DATA[3]~input_o\);

-- Location: LCCOMB_X32_Y22_N8
\inst|inst~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|inst~feeder_combout\ = \DATA[3]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \DATA[3]~input_o\,
	combout => \inst|inst~feeder_combout\);

-- Location: FF_X32_Y22_N9
\inst|inst\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst|inst~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|inst~q\);

-- Location: IOIBUF_X22_Y31_N8
\DATA[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_DATA(2),
	o => \DATA[2]~input_o\);

-- Location: LCCOMB_X22_Y30_N0
\inst|inst1~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|inst1~feeder_combout\ = \DATA[2]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \DATA[2]~input_o\,
	combout => \inst|inst1~feeder_combout\);

-- Location: FF_X22_Y30_N1
\inst|inst1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst|inst1~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|inst1~q\);

-- Location: IOIBUF_X31_Y31_N1
\DATA[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_DATA(1),
	o => \DATA[1]~input_o\);

-- Location: LCCOMB_X31_Y30_N16
\inst|inst5~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|inst5~feeder_combout\ = \DATA[1]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \DATA[1]~input_o\,
	combout => \inst|inst5~feeder_combout\);

-- Location: FF_X31_Y30_N17
\inst|inst5\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst|inst5~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|inst5~q\);

-- Location: IOIBUF_X16_Y31_N1
\DATA[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_DATA(0),
	o => \DATA[0]~input_o\);

-- Location: LCCOMB_X16_Y30_N16
\inst|inst6~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|inst6~feeder_combout\ = \DATA[0]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \DATA[0]~input_o\,
	combout => \inst|inst6~feeder_combout\);

-- Location: FF_X16_Y30_N17
\inst|inst6\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst|inst6~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|inst6~q\);

ww_REG(11) <= \REG[11]~output_o\;

ww_REG(10) <= \REG[10]~output_o\;

ww_REG(9) <= \REG[9]~output_o\;

ww_REG(8) <= \REG[8]~output_o\;

ww_REG(7) <= \REG[7]~output_o\;

ww_REG(6) <= \REG[6]~output_o\;

ww_REG(5) <= \REG[5]~output_o\;

ww_REG(4) <= \REG[4]~output_o\;

ww_REG(3) <= \REG[3]~output_o\;

ww_REG(2) <= \REG[2]~output_o\;

ww_REG(1) <= \REG[1]~output_o\;

ww_REG(0) <= \REG[0]~output_o\;
END structure;


