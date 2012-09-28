# Códigos Postales Mexicanos

Este es un script que toma el archivo descargable de Correos de México, en formato TXT y mete los datos que consideré importantes a una base de datos en MongoDB.

## Schema:

De un Código postal:

	{
		"_id" : "06760-0966", //El código postal con su identificador de asentamiento
		"cp" : "06760", //El código postal en formato string, ya que un int le quitaría el 0 del principio
		"estado" : 9, //el _id del estado
		"municipio" : "Cuauhtémoc", //El municipio o delegación
		"ciudad": "México", //La ciudad, en este caso no existe, pregúntale a CdM porqué...
		"colonia" : "Roma Sur", //la colonia
		"tipo" : "colonia", //El tipo de demarcación, 
		"zona" : "urbano" //El tipo de Zona
	}

De un estado:

    {
		"_id" : 9,
		"nombre" : "Distrito Federal"
	}

### Índices

Deberíamos de indexar la información de la siguiente manera:

    db.cp.ensureIndex({cp:1})
	db.cp.ensureIndex({estado:1})
	

### Tipos de zonas:

Con MongoDB >= 2.1 podemos hacer:

	db.cp.aggregate({$project:{zona:1}}, {$group:{_id:"$zona"}})

- Rural
- Semiurbano
- Urbano

### Tipos de, ehm, tipos:

Con MongoDB >= 2.1 podemos hacer:

	db.cp.aggregate({$project:{tipo:1}}, {$group:{_id:"$tipo"}})

- aeropuerto,
- ampliacion,
- barrio,
- campamento,
- ciudad,
- club de golf,
- colonia,
- condominio,
- congregacion,
- conjunto habitacional,
- ejido,
- equipamiento,
- estacion,
- exhacienda,
- finca,
- fraccionamiento,
- gran usuario,
- granja,
- hacienda,
- ingenio,
- parque industrial,
- poblado comunal,
- pueblo,
- puerto,
- rancho o rancheria,
- residencial,
- unidad habitacional,
- villa,
- zona comercial,
- zona federal, y
- zona industrial


# Por qué

[Correos de México](http://www.correosdemexico.gob.mx/ServiciosLinea/Paginas/DescargaCP.aspx) provee una lista de códigos postales en formatos CSV, XML y Excel, pero parsearlos es una hueva, sobre todo cuándo no están al tanto de que las caracteres de comas en un CSV se escapan, que los XML deben de ser válidos, que la codificación chida para formatos de intercambio es UTF-8 y que a ningún buen usuario de estos datos le interesa usar Excel.


# Licencia

>DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
>Version 2, December 2004
>
>(C) 2012 Partido Surrealista Mexicano <magritte@surrealista.mx>
>
>Everyone is permitted to copy and distribute verbatim or modified
>copies of this license document, and changing it is allowed as long
>as the name is changed.
>
>DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
>TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
>
>0. You just DO WHAT THE FUCK YOU WANT TO.