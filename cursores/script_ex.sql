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