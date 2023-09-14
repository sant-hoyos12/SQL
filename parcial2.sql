--Parcial 1--

--Punto1--
create role estudiante;
grant select on curso,grupo,inscripcion
to estudiante;

--Punto 2--
create or replace view oferta_academica as 
select d.id as departamento_id, d.nombre as departamento_nombre, c.id as curso_id, c.nombre as curso_nombre,c.creditos,g.id as grupo_id, g.nombre as grupo_nombre, g.anio,g.periodo
from departamento d left join curso c on (d.id=c.id_departamento)
					left join grupo g on (c.id=g.id_curso)
					
select * from oferta_academica

--Punto 3--
alter table estudiante 
add column monitor int;

alter table estudiante
add constraint mon_recursive foreign key (monitor) references estudiante(codigo);

--a--
update estudiante
set monitor = 1
where codigo = 3;

--b--
update estudiante
set monitor = 4
where codigo = 2;

--c--
update estudiante
set monitor = 3
where codigo = 4;

--Punto 4--
with recursive monitores_Lisa as(
	(select nombre,apellido, monitor
	 from estudiante
	 where codigo=4)
	union
	(select est.nombre, est.apellido, est.monitor
	 from estudiante est 
	 join monitores_Lisa mon on (mon.monitor=est.codigo))
)select * from monitores_Lisa;

--Punto 5--
select e.codigo, e.nombre, e.apellido, c.nombre as curso_nombre, c.creditos, i.calificacion,rank() over (
	order by i.calificacion)
	posicion
from estudiante e join inscripcion i on (e.codigo=i.codigo_estudiante)
				  join grupo g on (i.id_grupo=g.id)
				  join curso c on (g.id_curso=c.id)


