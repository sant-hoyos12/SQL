--join, left join, right join--
select e.nombre, e.apellido, d.nombre
from estudiante e, departamento d
where e.id_departamento=d.id

select e.nombre, e.apellido, d.nombre
from estudiante e join departamento d on (e.id_departamento = d.id)

-left join-
select d.nombre, c.nombre
from departamento d left join curso c on (d.id=c.id_departamento)

-right join-
select d.nombre, c.nombre
from departamento d right join curso c on (d.id=c.id_departamento)

-eje1-
select d.nombre, count(c.id)
from departamento d left join curso c on (d.id=c.id_departamento)
group by d.nombre

-eje2-
select distinct p.nombre, p.apellido, g.anio,  g.periodo
from  grupo join curso c on (grupo.id_curso=c.id), profesor p left join grupo g on (p.id = g.id_profesor)
where p.id not in (select p.id
				   from grupo g join profesor p on (g.id_profesor=p.id)
				   where g.anio=2021 and g.periodo=1)
					   
-eje3-
select distinct p.nombre, p.apellido, g.anio,  g.periodo
from  grupo join curso c on (grupo.id_curso=c.id), profesor p left join grupo g on (p.id = g.id_profesor)
where p.id not in (select p.id
				   from grupo g join profesor p on (g.id_profesor=p.id)
				   where g.anio=2020 and g.periodo=2)
				   			  
-eje4-
select d.nombre
from departamento d left join profesor p on (d.id=p.id_departamento)
where p.id is null

select p.nom_dep
from (select d.nombre as nom_d, p.id as id_p 
	  from departamento d left join profesor p on (d.id=p.id_departamento)) as profes
where profes.id_p is null

