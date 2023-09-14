--Parcial--
--1--
create role Estudiante;
grant select on grupo,curso,inscripcion
to Estudiante

--2--
create or replace view oferta_academica as
select d.id, d.nombre, c.id as cur_id, c.nombre as cur_nom, c.creditos, g.id as gru_id, g.nombre as gru_nom, g.anio, g.periodo
from departamento d join curso c on (d.id=c.id_departamento)
					join grupo g on (c.id=g.id_curso)
					
select * from oferta_academica

--3--
alter table estudiante
add column monitor int;

alter table estudiante
add constraint monitors foreign key (monitor) references estudiante(codigo)

-a-
update estudiante
set monitor = 1
where codigo =3

-b-
update estudiante
set monitor = 4
where codigo =2


-c-
update estudiante
set monitor = 3
where codigo = 4

--4--
with recursive mon_lisa as(
	(select monitor
	 from estudiante
	 where nombre='Lisa' and apellido='Simpson')
	union
	(select e.monitor
	from estudiante e
	join mon_lisa m on (e.codigo=m.monitor))
)select * from mon_lisa;

--5--
select e.codigo, e.nombre, e.apellido, c.nombre, c.creditos, rank() over (
	order by i.calificacion desc)
	posicion
from estudiante e join inscripcion i on (e.codigo=i.codigo_estudiante)
				  join grupo g on (i.id_grupo=g.id)
				  join curso c on (g.id_curso=c.id)

