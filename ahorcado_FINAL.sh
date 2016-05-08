#! /bin/bash


grupo(){
	clear
	echo
	echo
	echo "                         REALIZADO POR                       "
	echo "  ==========================================================="
	echo "  ||						           ||"
	echo "  ||	  Luis Rey Sanchez - luisreysn@gmail.com         ||"
	echo "  ||						           ||"			
	echo "  ==========================================================="
	echo
	echo " Pulsa ENTER para continuar..."
}

##Estas son las diferentes fases del ahorcado las cuales iremos mostrando 
##dependiendo del numero de fallos.
figura1(){
echo "					 _______  "
echo "					|/      | "
echo "					|         "
echo "					|         "	
echo "					|         "
echo "					|         "
echo "					|         "
echo "				   ssoo_|___      "
}
figura2(){
echo "					 _______   "
echo "					|/      |  "
echo "					|      (_) "
echo "					|          "
echo "					|          "
echo "					|          "
echo "					|          "  
echo "				   ssoo_|___       "
}
figura3(){
echo "					 _______   "
echo "					|/      |  "
echo "					|      (_) "
echo "					|       |  "	
echo "					|       |  "  
echo "					|          "
echo "					|          "    
echo "				   ssoo_|___       "
}
figura4(){
echo "					 _______   "
echo "					|/      |  "
echo "					|      (_) " 
echo "					|      /|  "
echo "					|       |  "  
echo "					|          "
echo "					|          "    
echo "				   ssoo_|___       "
}
figura5(){
echo "					 _______   "
echo "					|/      |  "
echo "					|      (_) "
echo "					|      /|\ "
echo "					|       |  "
echo "					|          "   
echo "					|          "   
echo "				   ssoo_|___       "
}
figura6(){
echo "					 _______   "
echo "					|/      |  "
echo "					|      (_) "
echo "					|      /|\ "
echo "					|       |  "
echo "					|      /   "   
echo "					|          "   
echo "				   ssoo_|___       "
}
figura7(){
echo "					 _______   "
echo "					|/      |  "
echo "					|      (_) "
echo "					|      /|\ "
echo "					|       |  "
echo "					|      / \ "   
echo "					|          "   
echo "				   ssoo_|___       "
}

pause(){
	read -p "$*"
}

if [[ $# -ne 1 ]] || [[ $1 != "conf.cfg" ]]
then
	echo
	echo " No has introducido el nombre del archivo de configuracion o lo has introducido mal."
	echo " El formato es el siguiente: ahorcado.sh conf.cfg"
	echo
	echo " Pulsa ENTER para continuar..."
	pause;
	clear
	exit 0
fi


DIRECCION_CONF=$1
if [ -f $DIRECCION_CONF ]
then
	echo El fichero de configuracion existe.
	DIRECCION_DICCIONARIO=`cat $DIRECCION_CONF | head -1`
	TAM_DIRECCION_DICCIONARIO=${#DIRECCION_DICCIONARIO}
	DIRECCION_DICCIONARIO=`cat $DIRECCION_CONF | head -1 | cut -c 14-$TAM_DIRECCION_DICCIONARIO`
	
	DIRECCION_ESTADISTICAS=`cat $DIRECCION_CONF | head -2 | tail -1`
	TAM_DIRECCION_ESTADISTICAS=${#DIRECCION_ESTADISTICAS}
	DIRECCION_ESTADISTICAS=`cat $DIRECCION_CONF | head -2 | tail -1 | cut -c 15-$TAM_DIRECCION_ESTADISTICAS`
	
	if [ -f $DIRECCION_DICCIONARIO ]
	then
		echo El archivo diccionario existe.	
	else
		echo
		echo El archivo DICCIONARIO no existe.
		echo Seleccione un archivo de diccionario válido en la configuracion.
		exit 0
		
	fi
	if [ -f $DIRECCION_ESTADISTICAS ]
	then
		echo El archivo estadisticas existe.
	else
		echo
		echo El archivo ESTADISTICAS no existe.
		echo Seleccione un archivo de estadísticas válido en la configuracion.
		pause;
	fi
else
	clear
	echo
	echo "  ==========================================================="
	echo "  ||						           ||"
	echo "  ||	  Error en la ruta del fichero configuracion       ||"
	echo "  ||						           ||"			
	echo "  ==========================================================="
	echo
	echo "  El archivo de configuracion no existe o la ruta es incorrecta."
	echo "  Indica una ruta valida como se muestra a continuacion:"
	echo "    ahorcado.sh ruta_archivo_conf "
	echo
	echo "  En el caso de no disponer de el crear uno nuevo."
	echo
	echo "  Pulsa ENTER para continuar..."
	pause;
	clear
	exit 0

fi

opc=null
PARTIDAS_JUGADAS=0
MODO_PRUEBA=0

until [ "$opc" = S ]
do
	clear
	echo "                     Bienvenido al juego del Ahorcado!"
	echo
	echo "                                _______   "
	echo "                               |/      |  "
	echo "                               |      (_) "
	echo "                               |      /|\ "	
	echo "                               |       |  "
	echo "                               |      / \ "
	echo "                               |          "
	echo "                          ssoo_|___  "
	echo
	echo
	echo "Elija una de las siguientes opciones:"
	echo "      J) JUGAR"
	echo "      E) ESTADISTICAS" 
	echo "      C) CONFIGURACION"
	echo "      A) AYUDA"
	echo "      G) GRUPO"
	echo "      S) SALIR"
	echo
	echo "Introduzca una opcion >>"
	
	read opc
	opc=`echo $opc |  tr '[a-z]' '[A-Z]'`
	if [[ ${#opc} -gt 1 ]]
	then
		opc=`echo $opc | cut -c 1`
	fi
	
	
	case $opc in
		J)
		if [[ -f $DIRECCION_DICCIONARIO ]] && [[ -f $DIRECCION_ESTADISTICAS ]] ;
			then
			#Variables a 0
			FALLOS=0
			ACIERTOS=0
			ACIERTOS=0
			INTENTOS=0
			BANDERA=0
			CONT=0
			BANDERA_GANAR=0
			BANDERA_PERDER=0
			TIEMPO_INI=$SECONDS
			TIEMPO_FIN=0
			TIEMPO_TOTAL=0
			X=1
			
			PARTIDAS_JUGADAS=$(($PARTIDAS_JUGADAS + 1))
			touch tmp1
			#Primero genero la palabra aleatoria a partir de un pid y un numero aleatorio.
			PID=`ps -e | cut -c 1-6 | sort | tail -1 | cut -c 5-6`
			NumAleatorio=$(( ( RANDOM % 99 ) + 1))
			SUMA=$(($VARIABLE+$NumAleatorio))
			MODULO=$(($SUMA%100))
			
			#Ya tengo la el nÃºmero aleatorio, ahora tengo que
			#buscar la palabra a la que equivale.
			PALABRA=`cat $DIRECCION_DICCIONARIO | head -$MODULO | tail -1`
			PALABRA=`echo $PALABRA |  tr '[a-z]' '[A-Z]'`
			TAM_PAL=`echo $((${#PALABRA} - 1))`    #Si se usa en Solaris o algunis sistemas antiguos restar 0 en vez de 1
			echo $PALABRA > tmp2
			
			#Vamos a separar las letras de la palabra y guardarlas en un array
			# en el cual cada subindice equivale a una letra.
			while [ $X -le $TAM_PAL ]
			do
				for CONT in $X
				do
					ARRAY_PAL[$CONT]=`cut -c ${CONT}-${CONT} < tmp2`
				done
			X=$(($X + 1))
			done
			
			#Crearemos un nuevo array tamaÃ±o $TAM_PAL y lo llenaremos de "_", este nuevo array
			#serÃ¡ el cual usemos despues para guardar las letras ya adivinadas.
			X=1
			while [ $X -le $TAM_PAL ]
			do
				for CONT in $X
				do
					ARRAY_PAL_2[$CONT]=_
				done
			X=$(($X + 1))
			done
			
			
			while [ "$BANDERA" -eq 0 ]
			do
				
				if [[ $FALLOS -eq 6 ]]
				then
					BANDERA_PERDER=1
				fi
				
				if [[ $ACIERTOS -eq $TAM_PAL ]]
				then
					BANDERA_GANAR=1
				fi
				
				clear
				echo
				echo "				Juego del Ahorcado"
				echo
				echo
				
				if [ $FALLOS -eq 0 ]
				then
					figura1;
				elif [ $FALLOS -eq 1 ]
				then
					figura2;
				elif [ $FALLOS -eq 2 ]
				then
					figura3;
				elif [ $FALLOS -eq 3 ]
				then
					figura4;
				elif [ $FALLOS -eq 4 ]
				then
					figura5;
				elif [ $FALLOS -eq 5 ]
				then
					figura6;
				else [ $FALLOS -eq 6 ]
					figura7;
				fi
					
				echo
				echo
				echo -n Palabra:
				X=1
				while [ $X -le $TAM_PAL ]
				do
					for CONT in $X
					do
						echo -n ${ARRAY_PAL_2[$CONT]}
					done
					X=$(($X + 1))
				done
				
				echo
				echo -n "Letras: "
				Z=1
				while [ $Z -le $INTENTOS ]
				do
					for CONT in $Z
					do
						echo -n "${ARRAY_LETRAS[$CONT]}, "
					done
					Z=$(($Z + 1))
				done
				echo	

				echo Fallos: $FALLOS
				echo Intentos: $INTENTOS
				echo
				if [[ $MODO_PRUEBA -eq 1 ]]
				then
					echo MODO PRUEBA: $PALABRA
				fi
				echo
				if [[ ( $BANDERA_GANAR -eq 0 ) && ( $BANDERA_PERDER -eq 0 ) ]]
				then
					echo -n "Introduce una letra >> "
					read LETRA
					LETRA=`echo $LETRA |  tr '[a-z]' '[A-Z]'`
					if [[ ${#LETRA} -gt 1 ]]
					then
						LETRA=`echo $LETRA | cut -c 1`
					fi
					
					BANDERA_REPETIDA=0
					Y=1
					while [ $Y -le $INTENTOS ]
					do
						for CONT in $Y
						do
							if [[ ${ARRAY_LETRAS[$CONT]} = $LETRA ]]
							then
								BANDERA_REPETIDA=1
								echo
								echo La letra introducida esta repetida. Introduce otra.
								pause;
							fi
						done
						Y=$(($Y + 1))
					done
					
					if [[ $BANDERA_REPETIDA -eq 0 ]]
					then
						INTENTOS=$(($INTENTOS + 1))
						#Guardamos la letra en el ARRAY_LETRAS
						for CONT in $INTENTOS
						do
							ARRAY_LETRAS[$CONT]=$LETRA
						done
					fi
					
				fi
				
				if [[ $BANDERA_REPETIDA -eq 0 ]]
				then
					CONT=0
					X=1
					BANDERA_ACERTADA=0
					while [ $X -le $TAM_PAL ]
					do
				
						for CONT in $X
						do
							
							if [[ $LETRA = ${ARRAY_PAL[$CONT]} ]]
							then
							#La LETRA si está en la PALABRA
								BANDERA_ACERTADA=1
								ARRAY_PAL_2[$CONT]=${ARRAY_PAL[$CONT]}
								ACIERTOS=$(($ACIERTOS + 1))
									
							fi						
						done
						X=$(($X + 1))
					done
					
					if [[ $BANDERA_ACERTADA -eq 0 ]]
					then
						FALLOS=$(($FALLOS + 1))
					fi
				fi
				
				if [[ $BANDERA_GANAR -eq 1 ]]
				then
					echo "   ***************************************************************"
					echo "   ||                                                            ||"
					echo "   ||                       HAS GANADO!!                         ||"
					echo "   ||    Enhorabuena! Lo has conseguido en $INTENTOS intentos            ||"
					echo "   ||                                                            ||"
					echo "   ***************************************************************"
					BANDERA=1
					
				fi
				
				if [[ $BANDERA_PERDER -eq 1 ]]
				then

					echo "   ***************************************************************"
					echo "   ||                                                            ||"
					echo "   ||                        LO SIENTO!!                         ||"
					echo "   ||             Has perdido! Has hecho $INTENTOS intentos              ||"
					echo "   ||                                                            ||"
					echo "   ***************************************************************"
					echo "   La palabra es $PALABRA"
					BANDERA=1
				fi
				
			done
			TIEMPO_FIN=$SECONDS
			TIEMPO_TOTAL=$(($TIEMPO_FIN - $TIEMPO_INI))
			echo "   Has tardado $TIEMPO_TOTAL segundos."
			echo
			echo " Pulsa ENTER para continuar..."
			pause;
			rm tmp1
			rm tmp2
			echo "$MODULO $PID $PALABRA $INTENTOS $FALLOS $TIEMPO_TOTAL" >> $DIRECCION_ESTADISTICAS

		else
			if [[ -f $DIRECCION_ESTADISTICAS ]]
			then
				echo El archivo de estadísticas existe.
			else
				echo El archivo de estadísticas NO existe.
				echo Edite en Configuración.
				pause;
			fi
			
			if [[ -f $DIRECCION_DICCIONARIO ]]; 
			then
				echo El archivo Diccionario existe.
			else
				echo El archivo Diccionario NO existe.
				echo Edite en Configuración.
				pause;
			fi

		fi
			;;
		E)
			if [[ -f $DIRECCION_ESTADISTICAS ]]
			then		
						X=1
                        SUMA_INTENTOS=0
                        NUM_PARTIDAS=0
                        SUMA_FALLOS=0
                                
                        NUM_PARTIDAS=`wc -l $DIRECCION_ESTADISTICAS | awk '{ print $1 }'`
                                        
                        while [ $X -le $NUM_PARTIDAS ]
                        do
                                for CONT in $X
                                do
                                        SUMA_INTENTOS=$(($SUMA_INTENTOS + `cat $DIRECCION_ESTADISTICAS | cut -d " " -f 4 | head -$CONT | tail -1`))
                                done
                                X=$(($X + 1))
                        done
                        MEDIA_INTENTOS=$(($SUMA_INTENTOS / $NUM_PARTIDAS))
                        
                        X=1 
                        while [ $X -le $NUM_PARTIDAS ]
                        do
                                for CONT in $X   
                                do
                                        SUMA_FALLOS=$(($SUMA_FALLOS + `cat $DIRECCION_ESTADISTICAS | cut -d " " -f 5 | head -$CONT | tail -1`))
                                done
                                X=$(($X + 1))
                        done
                        MEDIA_FALLOS=$(($SUMA_FALLOS / $NUM_PARTIDAS))
                        
                        X=1
                        while [ $X -le $NUM_PARTIDAS ]
                        do
                                for CONT in $X
                                do
                                        SUMA_TIEMPO=$(($SUMA_TIEMPO + `cat $DIRECCION_ESTADISTICAS | cut -d " " -f 6 | head -$CONT | tail -1`))
                                done
                                X=$(($X + 1))
                        done
                        MEDIA_TIEMPO=$(($SUMA_TIEMPO / $NUM_PARTIDAS ))

			
			clear
			echo
			echo
			echo "	                         ESTADISTICAS                       "  
                        echo "	  ==========================================================="
                        echo
                        echo "	  Numero total de partidas: $NUM_PARTIDAS "
                        echo "	  "
                        echo "	  MEDIAS TOTALES"
                        echo "	    - Numero medio de intentos: $MEDIA_INTENTOS"
                        echo "	    - Numero medio de fallos: $MEDIA_FALLOS"
                        echo "	    - Tiempo medio: $MEDIA_TIEMPO"
                        echo
                        echo "	  MEJORES JUGADAS"
                        echo "	    - Tiempo de la jugada más corta: `cat $DIRECCION_ESTADISTICAS | cut -d " " -f 6 | sort | head -1` "
                        echo "	    - Numero mínimo de fallos: `cat $DIRECCION_ESTADISTICAS | cut -d " " -f 5 | sort | head -1` "
                        echo "	    - Numero mínimo de intentos: `cat $DIRECCION_ESTADISTICAS | cut -d " " -f 4 | sort | head -1` "
                        echo
                        echo "	  PEORES JUGADAS"
                        echo "	    - Tiempo de la jugada más larga: `cat $DIRECCION_ESTADISTICAS | cut -d " " -f 6 | sort | tail -1`"
                        echo "	    - Número máximo de fallos: `cat $DIRECCION_ESTADISTICAS | cut -d " " -f 5 | sort | tail -1` "
                        echo "	    - Número máximo de intentos: `cat $DIRECCION_ESTADISTICAS | cut -d " " -f 4 | sort | tail -1` "
                        echo "	  "
                        echo "	  ==========================================================="
                        echo
                        echo " Pulsa ENTER para continuar..."
			pause;
			
			else
				echo
				echo El archivo estadísticas no existe.
				echo Cambie este en Configuración.
				pause;
			fi
			;;
		C)
			OPC=1
			until [ $OPC -eq 0 ]
			do
			
			clear
                        echo 
                        echo 
                        echo "	                         CONFIGURACION                       "  
                        echo "	  ==========================================================="  
                        echo "	      1. Configuracion:	$DIRECCION_CONF			     "
			echo "	      2. Diccionario: $DIRECCION_DICCIONARIO                 "
                        echo "	      3. Estadisticas: $DIRECCION_ESTADISTICAS               "
                        echo -n "	      4. Modo prueba: "
                        	if [[ $MODO_PRUEBA -eq 0 ]]
				then
					echo Desactivado
				else
					echo Activado
				fi
			echo
			echo "	      0. Salir                                        "
                        echo 
                        echo "	  ==========================================================="
                        echo 
                        echo
                        echo -n "Introduce la opcion para editarla >> "
			read OPC
			
			if [[ ${#OPC} -gt 1 ]]
			then
				OPC=`echo $OPC | cut -c 1`
			fi
			
			
				case $OPC in
					1)
						BANDERA_FICHERO=0
						echo 
						echo Introduce la nueva ruta para el archivo de Configuracion.
						echo -n "  >> "
						DIRECCION_CONF_ANTERIOR=$DIRECCION_CONF
						DIRECCION_DICCIONARIO_ANTERIOR=$DIRECCION_DICCIONARIO
						DIRECCION_ESTADISTICAS_ANTERIOR=$DIRECCION_ESTADISTICAS

						read DIRECCION_CONF
						echo

						if [[ -f $DIRECCION_CONF ]]
						then
							echo El fichero de configuracion existe.
							DIRECCION_DICCIONARIO=`cat $DIRECCION_CONF | head -1`
							TAM_DIRECCION_DICCIONARIO=${#DIRECCION_DICCIONARIO}
							DIRECCION_DICCIONARIO=`cat $DIRECCION_CONF | head -1 | cut -c 14-$TAM_DIRECCION_DICCIONARIO`
							
							DIRECCION_ESTADISTICAS=`cat $DIRECCION_CONF | head -2 | tail -1`
							TAM_DIRECCION_ESTADISTICAS=${#DIRECCION_ESTADISTICAS}
							DIRECCION_ESTADISTICAS=`cat $DIRECCION_CONF | head -2 | tail -1 | cut -c 15-$TAM_DIRECCION_ESTADISTICAS`
				
							if [[ -f $DIRECCION_DICCIONARIO ]]
							then
								echo El archivo diccionario existe.	
							else
								echo
								echo El archivo DICCIONARIO no existe.
								echo Edite el archivo $DIRECCION_CONF para solucionar el problema.
								#Si no existen los archivos vuelvo a poner la configuracion anterior.
								BANDERA_FICHERO=1
							fi
							if [[ -f $DIRECCION_ESTADISTICAS ]]
							then
								echo El archivo estadisticas existe.
							else
								echo
								echo El archivo ESTADISTICAS no existe.
								echo Edite el archivo $DIRECCION_CONF para solucionar el problema.
								#Si no existen los archivos vuelvo a poner la configuracion anterior.
								BANDERA_FICHERO=1
								fi
								
							if [[ $BANDERA_FICHERO = 1 ]]
							then
								echo
								echo Al no existir uno o los dos ficheros se estableceran los valores anteriores.
								DIRECCION_CONF=$DIRECCION_CONF_ANTERIOR
								DIRECCION_DICCIONARIO=$DIRECCION_DICCIONARIO_ANTERIOR
								DIRECCION_ESTADISTICAS=$DIRECCION_ESTADISTICAS_ANTERIOR
							fi
						else
							echo
							echo El fichero de CONFIGURACION no existe o la ruta es incorrecta.
							echo 
							DIRECCION_CONF=$DIRECCION_CONF_ANTERIOR
							DIRECCION_DICCIONARIO=$DIRECCION_DICCIONARIO_ANTERIOR
							DIRECCION_ESTADISTICAS=$DIRECCION_ESTADISTICAS_ANTERIOR
							
						fi	
						echo "Pulsa ENTER para continuar..."
						pause;
						 
					;;
					2)
						echo 
						echo Introduce la nueva ruta para el archivo de Diccionario.
						echo -n "  >> "
						DIRECCION_DICCIONARIO_ANTERIOR=$DIRECCION_DICCIONARIO
						read DIRECCION_DICCIONARIO
						
						if [[ -f $DIRECCION_DICCIONARIO ]]
							then
								echo El archivo DICCIONARIO existe.	
							else
								echo
								echo El archivo DICCIONARIO no existe.
								echo Seleccione otro archivo DICCIONARIO existente.
								#Si no existen los archivos vuelvo a poner la configuracion anterior.
								DIRECCION_DICCIONARIO=$DIRECCION_DICCIONARIO_ANTERIOR
							fi
						echo "Pulsa ENTER para continuar..."
						pause;
						clear
					;;
					3)
						echo 
						echo Introduce la nueva ruta para el archivo de Estadisticas.
						echo -n "  >> "
						DIRECCION_ESTADISTICAS_ANTERIOR=$DIRECCION_ESTADISTICAS
						read DIRECCION_ESTADISTICAS
						
						if [[ -f $DIRECCION_ESTADISTICAS ]]
							then
								echo El archivo ESTADISTICAS existe.	
							else
								echo
								echo El archivo ESTADISTICAS no existe.
								echo Seleccione otro archivo ESTADISTICAS existente.
								#Si no existen los archivos vuelvo a poner la configuracion anterior.
								DIRECCION_ESTADISTICAS=$DIRECCION_ESTADISTICAS_ANTERIOR
							fi
						echo "Pulsa ENTER para continuar..."
						pause;
					;;
					4)
						echo 
						echo "Active o desactive el Modo Prueba."
						echo "1. Activar"
						echo "2. Desactivar"
						echo
						echo -n "  >> "
						TEMP_PRUEBA=$MODO_PRUEBA
						read MODO_PRUEBA
						
						case $MODO_PRUEBA in
							1)
								MODO_PRUEBA=1
							;;
							2)
								MODO_PRUEBA=0
							;;
							*)
								echo
								echo " Opcion introducida NO valida."
								echo " Pulsa ENTER para continuar..."
								MODO_PRUEBA=$TEMP_PRUEBA
								pause;
							;;
						esac
						
					;;
					0)	
						echo salir
					;;
					*)
						echo " Opcion NO valida"
						echo " Pulsa ENTER para continuar..."
						OPC=99
						pause;
					;;
				esac
			done
			
			;;
		A)
			clear
			echo
			echo
			echo "                                AYUDA                         "  
                        echo "    ==========================================================="  
                        echo
                        echo "     Informacion de el juego del ahorcado."
                        echo "     En todas las entradas por teclado de los menus solamente"
                        echo "     se cogerá la primera letra de todas las introducidas. Es"
                        echo "     decir:  ASDF equivaldrá a A"
                        echo "     Esto también se aplicará al introducir letras en el Juego"
                        echo
                        echo "     En Configuración, la opcion MODO PRUEBAS sirve para poder"
                        echo "     ver la palabra que queremos adivinar y así comprobar el "
                        echo "     correcto funcionamiento del programa."
                        echo
                        echo "     En el caso de introducir una ruta a un fichero inexistente"
                        echo "     o desconocido aparecerá un mensaje de error indicando esto"
                        echo "     y que creemos o editemos el archivo que sea (segun el caso)"
                        echo "     En esta version del programa no se ha implementado ningun"
                        echo "     editor de archivos, posiblemente se agregue en futuras "
                        echo "     revisiones"
                        echo
                        echo "     "
                        echo "    ==========================================================="  
                        echo
                        echo "     Pulsa ENTER para volver al menu..."
			pause;
			;;
		G)
			grupo;
			pause;
			;;
		S)
			echo 
			;;
		*)
			echo OPCION INTRODUCIDA NO VALIDA
			pause;
			;;
	esac
	clear
done
exit 0



