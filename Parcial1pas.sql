--3--
select distinct e.nombre, e.apellido
from estudiante e
where e.fecha_nacimiento > make_date(cast(extract(year from current_date)-18 as integer),
									cast(extract(month from current_date) as integer),
									cast(extract(day from current_date) as integer))
									
--4--
select distinct p.nombre,p.apellido
from profesor p, departamento d
where p.id_departamento = 5

--5--
select count(i.codigo_estudiante)
from estudiante e, inscripcion i, grupo g, curso c
where e.codigo = i.codigo_estudiante and i.id_grupo = g.id 
and g.id_curso = c.id and g.anio = 2021 and g.periodo = 1 and c.nombre= 'Ingeniería de Datos' 

--6--
(select c.nombre, d.nombre
from curso c, departamento d
where c.id_departamento = d.id and d.nombre='MACC')
except
(select c.nombre, d.nombre
from horario h, grupo g, curso c, departamento d
where h.dia=4 and g.id_curso = c.id and g.id = h.id_grupo)

--7--
select distinct g.nombre,c.nombre, g.anio,g.periodo, h.hora_inicio,h.hora_fin
from curso c, grupo g, horario h
where g.id_curso = c.id and g.id = h.id_grupo and g.anio=2021 
and g.periodo=1 and c.nombre= 'Ingeniería de Datos' 

--8--

select distinct c.nombre as nombre_curso, g.nombre as nombre_grupo, 
h.dia,h.hora_inicio,h.hora_fin, e.nombre as nombre_edificio, s.nombre as nombre_salon
from departamento d, curso c, grupo g, horario h,edificio e, salon s
where d.nombre='MACC' and g.id_curso = c.id and g.id = h.id_grupo 
and h.id_salon = s.id and s.id_edificio =e.id and d.id = c.id_departamento
