-- qynvi
-- 01/24/2011
-- Finite State Machine RTL

library ieee;
use ieee.std_logic_1164.all;

entity FSMtimedmachine is
	generic (fclk: integer := 25;
			 sclk: integer := 8);
	port (clk,stop,rst: in std_logic;
		  ssd: out bit_vector(6 downto 0));
end FSMtimedmachine;

architecture tm of FSMtimedmachine is
	type state is (a,ab,b,bc,c,cd,d,de,e,ef,f,fa);
	signal pr_state,nx_state: state;
	shared variable cv: natural range 0 to 30 := 0;
	attribute enum_encoding: string;
	attribute enum_encoding of state: type is "sequential";
begin
	process (clk,rst,stop)
	variable ncounter: natural range 0 to fclk := 0;
	begin
		if (rst='1') then
			pr_state <= a;
			ncounter := 0;
		elsif (clk'event and clk='1') then
			if (stop='0') then
				ncounter := ncounter+1;
					if (ncounter>=cv) then
						pr_state <= nx_state;
					end if;
			end if;
		end if;
	end process;

	process (pr_state)
	begin
		case pr_state is
			when a =>
				ssd <= "0111111";
				nx_state <= ab;
				cv := sclk;
			when ab =>
				ssd <= "0011111";
				nx_state <= b;
				cv := fclk;
			when b =>
				ssd <= "1011111";
				nx_state <= bc;
				cv := sclk;
			when bc =>
				ssd <= "1001111";
				nx_state <= c;
				cv := fclk;
			when c =>
				ssd <= "1101111";
				nx_state <= cd;
				cv := sclk;
			when cd =>
				ssd <= "1100111";
				nx_state <= d;
				cv := fclk;
			when d =>
				ssd <= "1110111";
				nx_state <= de;
				cv := sclk;
			when de =>
				ssd <= "1110011";
				nx_state <= e;
				cv := fclk;
			when e =>
				ssd <= "1111011";
				nx_state <= ef;
				cv := sclk;
			when ef =>
				ssd <= "1111001";
				nx_state <= f;
				cv := fclk;
			when f =>
				ssd <= "1111101";
				nx_state <= fa;
				cv := sclk;
			when fa =>
				ssd <= "0111101";
				nx_state <= a;
				cv := fclk;
		end case;
	end process;
end architecture;
