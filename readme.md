# Scripts para la creacion automatizada de servidores

Estos scripts son una prueba de concepto para instalar servidores usando cloud-init de forma desatendida.

los scripts son los siguientes

* *.env* donde definir variables de entorno por defecto.
* *00_config.sh* Variables con valores por defecto.
* *01_check_dependencies.sh* Comprueba si los comandos que se usan estan disponibles.
* *02_build_config.sh* Crea la configuracion para realizar las instalaciones desatendidas.
* *user-data.tmpl* Una plantilla para generar la configuracion de la instalacion.
* *04_start_server* Arranca un servidor web que nos permite distribuir la configuracion via web.

* *50_kvm_autoinstall.sh* Usando kvm crea un disco qcow2 con la instalacion desatendida.
* *51_kvm_launch_machine.sh* Lanza un maquina virtual con el disco qcow2 recien creado.


Si se quiere hacer una instalacion desde el cd en una maquina real por ejemplo en ubuntu-server, y usar el servidor web como repositorio de configuracion, cuando se arranque del cd y veamos el menú de grub, entramos en el modo de edición y modificamos la linea referente al kernel para añadir las opciones de autoinstalación.

```data
linux       /casper/vmlinuz  ---
initrd      /casper/initrd
```

```data
linux       /casper/vmlinuz  autoinstall ds="nocloud-net;s=http://ipservidor:puerto/"  ---
initrd      /casper/initrd
```

OJO! no olvidar la / final despues del puerto