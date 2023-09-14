//distinct elimina repetidos

select distinct

Dentro del where
//in (que este en el conjunto)
//some (que alguno de los resultados)
//all (que todos los resultados)
//exists (existen registors para esta subconsulta)
//where not exists

Dentro del from

---------------------------------------------------------------
select distinct p.nombre, p.apellido
from profesor p, curso c, grupo g
where p.id = g.id_profesor and c.id = g.id_curso and c.nombre = 'Programacion de Computadores'
order by p.apellido, p.nombre ASC

select round(avg(i.calificacion),2)
from departamento d, estudiante e, inscripcion i
where d.nombre = 'MACC' and d.id = e.id_departamento and i.codigo_estudiante = e.codigo

select e.nombre, e.apellido, round(avg(i.calificacion),2)
from departamento d, estudiante e, inscripcion i
where d.nombre = 'Medicina' and d.id = e.id_departamento and i.codigo_estudiante = e.codigo
group by e.nombre, e.apellido

select e.nombre, e.apellido, round(avg(i.calificacion),2)
from departamento d, estudiante e, inscripcion i
where i.codigo_estudiante = e.codigo 
group by e.nombre, e.apellido
having round(avg(i.calificacion),2)>30.00







