--Taller 3--
-1a-
select c.nombre, c.creditos
from curso c join departamento d on (c.id_departamento=d.id)
			 join facultad f on (d.id_facultad=f.id)
where f.nombre = 'Economia' and c.creditos>=3

-1b-
select distinct p.nombre, p.apellido, g.anio, g.periodo
from profesor p left join grupo g on (p.id=g.id_profesor)
				join curso c on (g.id_curso=c.id)
where p.id not in (select p.id
				  from profesor p join grupo g on (p.id=g.id_profesor)
				  where g.anio=2020 and g.periodo=2)
				  
-2a-
create or replace view cur_fac as
select c.id as cur_id, c.nombre as cur_nom, d.nombre as dep_nom, f.nombre as fac_nom
from curso c join departamento d on (c.id_departamento=d.id)
			 join facultad f on (d.id_facultad=f.id)

-2c-
create or replace view prof_cur as
select p.nombre, p.apellido, c.nombre as cur_nom, d.nombre as dep_nom
from profesor p left join grupo g on (p.id=g.id_profesor)
				join curso c on (g.id_curso=c.id)
				join departamento d on (c.id_departamento=d.id)
				
-3a-			
alter table horario
add constraint hor_esp check (dia in (1,2,3,4,5))
