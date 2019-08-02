----------------------------------------------------------------------------------
-- Universidad Tecnológica Nacional
-- Carrera: Ingenieria en Electrónica
-- Materia: Tecnicas Digitales IV 
-- Año: 2014
-- Grupo Numero: 2

-- Integrantes del grupo: 
-- Donda, Lucio               leg:51490
-- Kunst, James	            leg:53255
-- Mattausch, Mariano         leg:47882

-- Nombre del Modulo:    fir.vhd
--Trabajo práctico 16.  
-- consigna: Realizar la implementación directa del filtro FIR diseñado en el práctico 15. 
--           Para verificar la implementación del filtro utilice el archivo fir_tb.vhd, con las modificaciones necesarias.
--FIR ARQUITECTURA DIRECTA

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;--agregar las otras librerias crea conflicto. 
 


-- FILTRO FIR IMPLEMENTACION DIRECTA

--empezamos analizando el testbech , y copiamos el componente instanciado y lo cambiamos a entity


entity fir is
  Generic(NBI     : integer := 12;		--número de bits de entrada.
          NBO     : integer := 12;		--número de bits de salida.
			 NBPP     : integer := 17;		--número de bits del producto parcial.
          NBACCUM : integer := 12+5;	--número de bits del acumulador.
			 NTAPS   : integer := 32);		--número de taps del filtro.
  Port(
    x     : in  signed(NBI-1 downto 0);  -- entrada del filtro.  x.dat 
    y     : out signed(NBO-1 downto 0);  -- salida del filtro.   y.dat
	 ce    : in  std_logic;
    clk   : in  std_logic
    );
end fir;    

 
architecture Behavioral of fir is
																					-- 383 downto 0;
signal shift_register : std_logic_vector(NBI*NTAPS-1 downto 0); --es std_logic, porque solo se lo usa como contenedor
			 																		  -- si fuera signed , puedo llegar a perder el signo

signal b : std_logic_vector(NBI*NTAPS-1  downto 0); -- 383 downto 0;

signal pp_s : std_logic_vector(NBPP*NTAPS-1 downto 0); --productos parciales
																	 -- 543 downto 0;


component coeffs      --Coeficientes b exportados desde matlab.
	Port (
			b: out std_logic_vector(NTAPS*NBI-1 downto 0));  -- 383 downto 0;
end component;
begin

--instanciacion del los coeficientes
i_coeffs: coeffs
Port map (b=>b);


process (clk)		--shift register
begin
 
if rising_edge(clk) then        --no puedo poner "and" poque viola las leyes del sincronismo 
	if CE='1' then
	 for i in NTAPS-1 downto 1 loop -- (31 downto 1)
   shift_register((i+1)*NBI-1 downto i*NBI)<=shift_register(i*NBI-1 downto (i-1)*NBI); --(383 downto 372)<=(371 downto 360)
                  --mas signifc.   --menos signifc. 
    end loop;

shift_register(NBI-1 downto 0)<=std_logic_vector(x); --cambio el tipo de dato para poder operar. X pasa de signed a std_logic_vector.
end if;
end if;
end process;



process (b,shift_register)		--productos parciales

variable tmp1 : signed(2*NBI-1 downto 0); 

begin 

  for i in 0 to NTAPS-1 loop 
		tmp1 :=signed(b(((i+1)*(NBI)-1) downto( i*NBI)))* signed(shift_register((i+1)*NBI-1 downto i*NBI)); --cacula el producto parcial con 24 bits
		pp_s((i+1)*NBPP-1 downto i*NBPP)<=std_logic_vector(tmp1(2*NBI-2 downto NBI-6));   --descarto el bit más significativo( el signo) y los 5 bits menos significativos.
																													 --Por lo que en pp_s quedan los 17 bits más significativos.
  end loop;


end process;


process(pp_s)		--sumador

variable accum: signed(NBACCUM-1 downto 0);    
                    
begin
accum:=to_signed(0,NBACCUM); --funcion que convierte a cero la cantidad de bits que pongo en el segundo argumento. Aca inicializamos a cero el acumulador.
	for i in 0 to NTAPS-1 loop
		accum:= signed(pp_s((i+1)*NBPP-1 downto i*NBPP))+ accum;	--convierte pp_s a tipo signed y lo sumo con los accum anteriores.
	end loop;
y <= accum(NBPP-1 downto NBPP-12);	-- salida del filtro.
end process;

end architecture Behavioral;
   
  