--view/vista--
select d.nombre as departamento_nom, e.nombre, e.apellido
from departamento d join curso c on (d.id=c.id_departamento)
					join grupo g on (c.id=g.id_curso)
					join inscripcion i on (g.id = i.id_grupo)
					join estudiante e on (i.codigo_estudiante=e.codigo)
where g.anio=2021 and g.periodo=1

select d.nombre as departamento_nom, e.nombre, e.apellido, c.nombre as curso_nom, g.anio, g.periodo, i.calificacion
from departamento d join curso c on (d.id=c.id_departamento)
					join grupo g on (c.id=g.id_curso)
					join inscripcion i on (g.id = i.id_grupo)
					join estudiante e on (i.codigo_estudiante=e.codigo)
where e.genero='F' and i.calificacion >30
					
create or replace view list_estudiantes as
select d.nombre as departamento_nom, e.nombre, e.apellido, c.nombre as curso_nom, g.anio, g.periodo, i.calificacion, e.genero
from departamento d join curso c on (d.id=c.id_departamento)
					join grupo g on (c.id=g.id_curso)
					join inscripcion i on (g.id = i.id_grupo)
					join estudiante e on (i.codigo_estudiante=e.codigo)
					
					
--aplicar--
select departamento_nom, nombre, apellido
from list_estudiantes
where anio=2021 and periodo=1

select departamento_nom, nombre, apellido, curso_nom, anio, periodo, calificacion
from list_estudiantes
where calificacion >30 and genero = 'F'

--transacciones--
-finaliza con commit(asegura todas las transacciones) o rollback(retroceder todos los cambios)-

select g.id
from curso c join grupo g on (c.id=g.id_curso)
where c.nombre = 'Ingeniería de Datos' and g.anio = 2021 and g.periodo = 1 and g.nombre = 'G1'

select id
from salon
where nombre = 'Hipatia'

insert into horario (dia,hora_inicio,hora_fin, id_grupo, id_salon)
values (5,16,18,id_grupo, id_salon)


--restricciones de identidad--
-cambios no generen incosistencia-
-tabla: not null, unique, check(posibles valores del atributo)-
