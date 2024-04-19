-- 1.1 Escreva um cursor que exiba as variáveis rank e youtuber de toda tupla que tiver
-- video_count pelo menos igual a 1000 e cuja category seja igual a Sports ou Music.

DO $$
DECLARE
cur_exibi REFCURSOR;
tupla RECORD;
video_count INT := 1000;
category_sport VARCHAR(200) := 'Sports';
category_music VARCHAR(200) := 'Music';
v_tabela VARCHAR(200) := 'tb_youtubers'; 

BEGIN
OPEN cur_exibi FOR EXECUTE
	format(
		'SELECT 
				youtuber, rank
		FROM tb_youtubers
		WHERE started >= $1 AND (category = $2 OR category = $3 ) 
		', v_tabela
	) USING video_count, category_sport,category_music;

	LOOP
	FETCH cur_exibi INTO tupla;
	EXIT WHEN NOT FOUND;
	RAISE NOTICE '%', tupla;
	
	END LOOP;
	CLOSE cur_exibi;
END;
$$

-- 1.2 Escreva um cursor que exibe todos os nomes dos youtubers em ordem reversa. Para tal
-- - O SELECT deverá ordenar em ordem não reversa
-- - O Cursor deverá ser movido para a última tupla
-- - Os dados deverão ser exibidos de baixo para cima

DO $$
DECLARE
cur_exibir REFCURSOR;
tupla RECORD;
ranking INTEGER;
BEGIN
OPEN cur_exibir FOR EXECUTE
	format(
	'SELECT * FROM tb_youtubers
ORDER BY ranking DESC;'
	)USING ranking;
	LOOP
	FETCH cur_exibir INTO tupla;
	EXIT WHEN NOT FOUND;
	RAISE NOTICE '%', tupla;
	END LOOP;
	CLOSE cur_exibir;
END
$$

-- 1.3 Faça uma pesquisa sobre o anti-pattern chamado RBAR - Row By Agonizing Row.
-- Explique com suas palavras do que se trata.
-- é Basicamente um metódo de processamento de dados que trata cada linha separadamente , ou seja
-- uma por uma , tornando o processo as vezes muito mais lento, só é vantajoso em casos especificos
-- como Necessidade de lógica complexa por linha se cada linha do conjunto de dados exigir uma 
-- lógica de processamento muito específica e complexa, pode ser mais fácil implementar 
-- essa lógica usando o RBAR, em vez de tentar construir consultas SQL complexas para lidar com todos os casos.

-- CREATE TABLE tb_youtubers(
-- cod_top_youtubers SERIAL PRIMARY KEY,
-- rank INT,
-- youtuber VARCHAR(200),
-- subscribers INT,
-- video_views VARCHAR(200),
-- video_count INT,
-- category VARCHAR(200),
-- started INT
-- );
-- --alter table
-- ALTER TABLE tb_youtubers
-- 	ALTER COLUMN video_views
-- 	TYPE BIGINT USING video_views::BIGINT;
	
-- ALTER TABLE tb_youtubers
-- RENAME COLUMN rank TO ranking;

-- ALTER TABLE tb_youtubers
-- 	ALTER COLUMN ranking
-- 	TYPE BIGINT USING video_views::BIGINT;
	
-- ALTER TABLE tb_youtubers
-- 	ALTER COLUMN ranking
-- 	TYPE integer USING video_views::integer;
	
-- SELECT * FROM tb_youtubers
-- ORDER BY ranking DESC;
-- $$

