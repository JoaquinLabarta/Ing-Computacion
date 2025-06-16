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

-- DATE "06/16/2025 13:09:31"

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

ENTITY 	tp2 IS
    PORT (
	B8 : OUT std_logic;
	Clock : IN std_logic;
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
-- B8	=>  Location: PIN_K8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B7	=>  Location: PIN_N4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B6	=>  Location: PIN_N8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B5	=>  Location: PIN_N9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B4	=>  Location: PIN_K9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B3	=>  Location: PIN_L7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B2	=>  Location: PIN_L5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B1	=>  Location: PIN_N6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B0	=>  Location: PIN_M6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Clock	=>  Location: PIN_J7,	 I/O Standard: 2.5 V,	 Current Strength: Default


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
SIGNAL ww_Clock : std_logic;
SIGNAL ww_B7 : std_logic;
SIGNAL ww_B6 : std_logic;
SIGNAL ww_B5 : std_logic;
SIGNAL ww_B4 : std_logic;
SIGNAL ww_B3 : std_logic;
SIGNAL ww_B2 : std_logic;
SIGNAL ww_B1 : std_logic;
SIGNAL ww_B0 : std_logic;
SIGNAL \Clock~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \B8~output_o\ : std_logic;
SIGNAL \B7~output_o\ : std_logic;
SIGNAL \B6~output_o\ : std_logic;
SIGNAL \B5~output_o\ : std_logic;
SIGNAL \B4~output_o\ : std_logic;
SIGNAL \B3~output_o\ : std_logic;
SIGNAL \B2~output_o\ : std_logic;
SIGNAL \B1~output_o\ : std_logic;
SIGNAL \B0~output_o\ : std_logic;
SIGNAL \Clock~input_o\ : std_logic;
SIGNAL \Clock~inputclkctrl_outclk\ : std_logic;
SIGNAL \D0M|5~0_combout\ : std_logic;
SIGNAL \D0~q\ : std_logic;
SIGNAL \D2~0_combout\ : std_logic;
SIGNAL \D2~q\ : std_logic;
SIGNAL \D1M|5~1_combout\ : std_logic;
SIGNAL \D1~q\ : std_logic;
SIGNAL \D1M|5~0_combout\ : std_logic;
SIGNAL \inst36~combout\ : std_logic;
SIGNAL \inst45~combout\ : std_logic;
SIGNAL \inst23~combout\ : std_logic;
SIGNAL \inst29~combout\ : std_logic;
SIGNAL \inst27~combout\ : std_logic;
SIGNAL \inst31~combout\ : std_logic;

BEGIN

B8 <= ww_B8;
ww_Clock <= Clock;
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

\Clock~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \Clock~input_o\);

-- Location: IOOBUF_X22_Y0_N9
\B8~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \D1M|5~0_combout\,
	devoe => ww_devoe,
	o => \B8~output_o\);

-- Location: IOOBUF_X10_Y0_N9
\B7~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst36~combout\,
	devoe => ww_devoe,
	o => \B7~output_o\);

-- Location: IOOBUF_X20_Y0_N9
\B6~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst45~combout\,
	devoe => ww_devoe,
	o => \B6~output_o\);

-- Location: IOOBUF_X20_Y0_N2
\B5~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \D1~q\,
	devoe => ww_devoe,
	o => \B5~output_o\);

-- Location: IOOBUF_X22_Y0_N2
\B4~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst23~combout\,
	devoe => ww_devoe,
	o => \B4~output_o\);

-- Location: IOOBUF_X14_Y0_N2
\B3~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst29~combout\,
	devoe => ww_devoe,
	o => \B3~output_o\);

-- Location: IOOBUF_X14_Y0_N9
\B2~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \D2~q\,
	devoe => ww_devoe,
	o => \B2~output_o\);

-- Location: IOOBUF_X12_Y0_N2
\B1~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst27~combout\,
	devoe => ww_devoe,
	o => \B1~output_o\);

-- Location: IOOBUF_X12_Y0_N9
\B0~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst31~combout\,
	devoe => ww_devoe,
	o => \B0~output_o\);

-- Location: IOIBUF_X16_Y0_N15
\Clock~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Clock,
	o => \Clock~input_o\);

-- Location: CLKCTRL_G17
\Clock~inputclkctrl\ : cycloneiv_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \Clock~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \Clock~inputclkctrl_outclk\);

-- Location: LCCOMB_X16_Y1_N14
\D0M|5~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \D0M|5~0_combout\ = \Clock~input_o\ $ (!\D0~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101001010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Clock~input_o\,
	datad => \D0~q\,
	combout => \D0M|5~0_combout\);

-- Location: FF_X16_Y1_N25
D0 : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~inputclkctrl_outclk\,
	asdata => \D0M|5~0_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \D0~q\);

-- Location: LCCOMB_X16_Y1_N22
\D2~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \D2~0_combout\ = (\Clock~input_o\ & (((\D2~q\)))) # (!\Clock~input_o\ & ((\D0~q\ & (\D1~q\)) # (!\D0~q\ & ((\D2~q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \D1~q\,
	datab => \Clock~input_o\,
	datac => \D2~q\,
	datad => \D0~q\,
	combout => \D2~0_combout\);

-- Location: FF_X16_Y1_N9
D2 : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~inputclkctrl_outclk\,
	asdata => \D2~0_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \D2~q\);

-- Location: LCCOMB_X16_Y1_N4
\D1M|5~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \D1M|5~1_combout\ = (\Clock~input_o\ & (((\D1~q\)))) # (!\Clock~input_o\ & ((\D1~q\ & ((!\D0~q\))) # (!\D1~q\ & (!\D2~q\ & \D0~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Clock~input_o\,
	datab => \D2~q\,
	datac => \D1~q\,
	datad => \D0~q\,
	combout => \D1M|5~1_combout\);

-- Location: FF_X16_Y1_N31
D1 : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \Clock~inputclkctrl_outclk\,
	asdata => \D1M|5~1_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \D1~q\);

-- Location: LCCOMB_X16_Y1_N24
\D1M|5~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \D1M|5~0_combout\ = (!\D1~q\ & !\D2~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \D1~q\,
	datad => \D2~q\,
	combout => \D1M|5~0_combout\);

-- Location: LCCOMB_X16_Y1_N8
inst36 : cycloneiv_lcell_comb
-- Equation(s):
-- \inst36~combout\ = (\D1~q\) # ((\D2~q\) # (!\D0~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \D1~q\,
	datac => \D2~q\,
	datad => \D0~q\,
	combout => \inst36~combout\);

-- Location: LCCOMB_X16_Y1_N30
inst45 : cycloneiv_lcell_comb
-- Equation(s):
-- \inst45~combout\ = (\D0~q\) # ((\D1~q\) # (\D2~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \D0~q\,
	datac => \D1~q\,
	datad => \D2~q\,
	combout => \inst45~combout\);

-- Location: LCCOMB_X16_Y1_N26
inst23 : cycloneiv_lcell_comb
-- Equation(s):
-- \inst23~combout\ = (!\D1~q\) # (!\D0~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \D0~q\,
	datad => \D1~q\,
	combout => \inst23~combout\);

-- Location: LCCOMB_X16_Y1_N20
inst29 : cycloneiv_lcell_comb
-- Equation(s):
-- \inst29~combout\ = (\D0~q\) # (!\D1~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \D0~q\,
	datad => \D1~q\,
	combout => \inst29~combout\);

-- Location: LCCOMB_X16_Y1_N18
inst27 : cycloneiv_lcell_comb
-- Equation(s):
-- \inst27~combout\ = (!\D2~q\) # (!\D0~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \D0~q\,
	datad => \D2~q\,
	combout => \inst27~combout\);

-- Location: LCCOMB_X16_Y1_N28
inst31 : cycloneiv_lcell_comb
-- Equation(s):
-- \inst31~combout\ = (\D0~q\) # (!\D2~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \D0~q\,
	datad => \D2~q\,
	combout => \inst31~combout\);

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


