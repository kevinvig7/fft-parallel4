
-- Este testbench utiliza entradas y salidas leídas desde una archivo de datos para hacer las comprobaciones
-- Pasos a seguir
-- 1) Generar los archivos x.dat e y.dat con matlab (entrada y salida del filtro)
-- 2) Copiar los archivos x.dat e y.dat, a la carpeta del proyecto
-- 3) Agregar al proyecto los archivos txt_util.vhd (provisto) y fir.vhd (a generar)
-- 4) Correr la simulación y verificar la ausencia de errores
 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use std.textio.all;             --librerias extra en la carpeta del proyecto txt_util.vhd
use work.txt_util.all; 

ENTITY fir_tb IS
END fir_tb;

ARCHITECTURE behavior OF fir_tb IS 
  
  constant NBI     : integer := 12;
  constant NBO     : integer := 12;
  constant NBPP     : integer := 17;
  constant NBACCUM : integer := 12+5;
  constant NTAPS   : integer := 32;

  -- Declaracion de componentes
  COMPONENT fir
  GENERIC(NBI     : integer := NBI;
          NBO     : integer := NBO;
			 NBPP    : integer := NBPP;
          NBACCUM : integer := 12+5;
			 NTAPS   : integer := NTAPS);
			 
  PORT(
    x     : IN  signed(NBI-1 downto 0);    
    y     : OUT signed(NBO-1 downto 0);
    ce    : IN  std_logic;
    clk   : IN  std_logic
    );
  END COMPONENT;    

  -- Entradas
  signal x       : signed(NBI-1 downto 0) := (others => '0');  
  signal ce      : std_logic := '0';
  signal clk     : std_logic := '0';
  
  -- Salidas
  signal y       : signed(NBO-1 downto 0) := (others => '0');
  signal y_tb    : signed(NBO-1 downto 0) := (others => '0');

  signal y_check : std_logic;

  -- Definicion de periodo de reloj
  constant clk_period : time := 10 ns;
  
  FILE x_id      : text   open read_mode is "x.dat";
  FILE y_id      : text   open read_mode is "y.dat";
  

  signal check_count    : integer := 0;
BEGIN
 
  -- Unidad bajo prueba
  uut: fir PORT MAP (
    x     => x,
    y     => y,
    ce    => ce,
    clk   => clk
    );

  -- Proceso de generación de reloj
  clk_process :process
  begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
  end process;

  -- Habilitación de muestras
  ce <= '1';
  
  -- Proceso de generación de clock enable
  y_check<= '1' when y=y_tb else '0'; 
  
   

  -- Estimulo
  stim_proc: process
    variable l  : line;
    variable sx : string(NBI downto 1);
    variable sy : string(NBO downto 1);
    
  begin		
    
    wait for 100 ns;	
   
    for i in 0 to NTAPS loop
       wait until rising_edge(clk) and ce='1';
    end loop;

    while not endfile( x_id ) loop	
      
      readline (x_id, l);
      read (l, sx) ;
      x<=signed(to_std_logic_vector(sx));

      if check_count>NTAPS-2 then
        readline (y_id,l);
        read(l,sy);
        y_tb<=signed(to_std_logic_vector(sy));
	       
      end if;

      wait until rising_edge(clk) and ce='1';	

      if check_count>50 then
        assert y_check='1' report "error en la salida" severity error;
		  
      else
        check_count <= check_count+1;
       end if; 

    end loop;	

    wait;
  end process;

END;
