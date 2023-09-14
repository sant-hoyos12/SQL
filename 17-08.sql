--1d--

select e.nombre, e.apellido, e.fecha_nacimiento, c.nombre
from estudiante e, curso c, inscripcion i, grupo g
where e.codigo = i.codigo_estudiante and i.id_grupo = g.id and g.id_curso = c.id 
and e.fecha_nacimiento > make_date(cast(Extract(year from current_date)-20 as integer),
									cast(Extract(month from current_date) as integer), 
									cast(Extract(day from current_date) as integer))
and c.nombre= 'Ingeniería de Datos' 
order by e.fecha_nacimiento

--1g--

(select p.nombre, p.apellido
from profesor p)
except(select p.nombre, p.apellido
	   from profesor p, grupo g
	   where p.id = g.id_profesor and g.anio = 2021 and g.periodo = 1)
	   
--2a--

select e.nombre, e.apellido, i.calificacion
from estudiante e, inscripcion i
where e.codigo=i.codigo_estudiante
and e.fecha_nacimiento < make_date(cast(Extract(year from current_date)-18 as integer),
									cast(Extract(month from current_date) as integer), 
									cast(Extract(day from current_date) as integer))
and i.calificacion>some(select i.calificacion
						from inscripcion i, estudiante e,departamento d
						where d.nombre='MACC'and d.id=e.id_departamento and e.codigo=i.codigo_estudiante and e.genero='F'
					   )
					   
--2b--

select distinct c.id, c.nombre, g.id
from curso c, grupo g
where not exists (select c.id, c.nombre , g.id
				  from curso c, inscripcion i, grupo g, estudiante e
				  where i.codigo_estudiante=e.codigo and g.id=i.id_grupo)

	  
--2c--



