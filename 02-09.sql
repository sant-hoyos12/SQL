--Funciones--
create function contar_estudiantes (depto varchar(20)) returns int
language plpgsql as
$$
declare
	cuenta int;
begin
	select count(e.codigo) into cuenta
	from estudiante e join departamento d on (e.id_departamento= d.id)
	where d.nombre = depto;
	return cuenta;
end;
$$

select contar_estudiantes('MACC')

-ejecicio-
-1-
alter table estudiante
add mayor_edad boolean

create or replace function mayor_edad(edad int) returns int
language plpgsql as
$$
declare
	fecha date;
	cuenta int;
	anio int;
	mes int;
	dia int;
begin
	anio = extract(year from current_date) - edad;
	mes = extract(month from current_date);
	dia = extract(day from current_date);
	fecha = make_date(anio,mes,dia);
	
	select count(codigo) into cuenta
	from estudiante
	where fecha_nacimiento <= fecha;
	
	update estudiante
	set mayor_edad = 'true'
	where fecha_nacimiento <= fecha;
	
	update estudiante
	set mayor_edad = 'false'
	where fecha_nacimiento > fecha;
	
	return cuenta;
end;
$$

select mayor_edad(18)

-2-
alter table estudiante
add promedio real

create or replace function promedio() returns real
language plpgsql
as 
$$
declare
	prom real;
    suma_calif real;
    suma_creditos real;
    prom_total real;
    num_est real;
    cod int;
begin
	prom_total = 0;
    num_est = 0;
	for cod in (select codigo from estudiante)
    loop
          select sum(ins.calificacion*cur.creditos) into suma_calif
          from estudiante est
          join inscripcion ins on (est.codigo = ins.codigo_estudiante)
          join grupo gru on (ins.id_grupo = gru.id)
          join curso cur on (gru.id_curso = cur.id)
          where est.codigo = cod;
          select sum(cur.creditos) into suma_creditos
          from estudiante est
          join inscripcion ins on (est.codigo = ins.codigo_estudiante)
          join grupo gru on (ins.id_grupo = gru.id)
          join curso cur on (gru.id_curso = cur.id)
          where est.codigo = cod;
		  if suma_creditos <> 0 then
              prom = suma_calif / suma_creditos;
              prom_total = prom_total + prom;
              num_est = num_est + 1;
              update estudiante
              set promedio = prom
              where codigo = cod;
          end if;
      end loop;
      prom_total = prom_total / num_est;
      return prom_total;
end;
$$

select promedio()
--Procedimientos--
create or replace procedure dept (in bla int, out bla int)
begin
	ss
end;

