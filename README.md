# LDAP-contra-el-mundo
En esta ocasión vamos a trabajar con LDAP. 

Descripción de la infraestructura que habrá que lanzar con terraform, githubActions.....

Tenemos una única VPC:

Subred Pública.
Servidor web, Servidor de aplicaciones (Host de bastionado)
Subred Privada.
Ldap
En principio podéis trabajar con IPs pero sabéis que no es lo aconsejable, por lo que os remito a Router53 en su parte de hosted privado (este puede ser sin terraform).

Y ahora la pregunta del millón ¿para qué LDAP? pues para tener una parte de administración en la página web que llevamos. 

Y para todo aquellos que tengan dudas, por supuesto, todo securizado y en contenedores por si las moscas.
