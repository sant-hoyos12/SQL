select est.nombre, est.apellido, est.estatura
from estudiante est
where est.estatura<165 and est.genero='F'
union 
select est.nombre, est.apellido, est.estatura
from estudiante est
where est.estatura>175 and est.genero='M' 

select round(avg(estatura),2)
from estudiante
where genero ='M'
union
select round(avg(estatura),2)
from estudiante
where genero ='F'

select round(min(estatura),2)
from estudiante
where genero ='M'
union
select round(min(estatura),2)
from estudiante
where genero ='F'


select count(codigo)
from estudiante


select genero, round(avg(estatura),2) as prom_est
from estudiante
group by genero
order by prom_est asc


select dep.nombre, count(est.codigo)
from estudiante est, departamento dep
where dep.id =est.id_departamento
group by dep.nombre

select dep.nombre, count(est.codigo) as cuenta
from estudiante est, departamento dep
where dep.id =est.id_departamento
group by dep.nombre
having count(est.codigo) > 2 

