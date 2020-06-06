main () {

option=0

while  [ $option  -ne  7  ];do

cat << END
Bienvenido. Por favor ingrese la opcion deseada de 1 a la 5 :
1.Ingrese un numero entero para obtener esa cantidad de elementos de la sucesion de Fibonacci.
2.Ingrese un numero entero para obtener por pantalla ese numero en forma invertida.
3.Ingrese una cadena de caracteres para saber si es palindromo o no.
4.Ingrese el path a un archivo de texto para obtener por pantalla la cantidad de lineas que tiene.
5.Ingrese 5 numeros enteros para obtenerlos en forma ordenada.
6.Ingrese el path a un directorio para obtener cuantos archivos de cada tipo contiene (Sin contar ./ y ../).
7.Salir Adios User.
END

read option

chooseOption $option

done

}


chooseOption () {
case $1 in 
	1) 
	fibonacci
	;;
	2) 
	invert
	;;
	3) 
	palindrome
	;;
	4) 
	countLines
	;;
	5) 
	orderArray
	;;
	6) 
	getNumberOfFiles
	;;
	7) 
	goodbye
	;;

esac

}

fibonacci () {

  echo "ingrese cantidad de numeros de la sucesion de fibonacci que desea ver"
  
  read amount 
  
  echo "La serie de fibonnacci es"
  
  a=0
  b=1
  
  results=( 0 1 )
  for (( i=0; i<amount; i++ ))
  do
      sum=$((a + b))
      results+=($sum)
      a=$b
      b=$sum
  done
  
  echo ${results[*]}
  echo -e "\n"

}

invert () {

	echo "Ingresar un numero para que sea invertido"

    read number 

	numberLength=${#number}
	toTake=${#number}
	toTake=$((toTake -1))
    inverted=""

    for (( i=$toTake; i>=0; i-- ))
    do
	   inverted=${inverted}${number:$i:1}
    done

	echo $inverted
}

palindrome () {

    echo "Ingresar una cadena de caracteres para ver si es palindromo o no"

    read number 

	numberLength=${#number}
    iterate=$(($numberLength / 2))
    iterate=$(($iterate -1))
    isPalindrome=true
	count=0
	firstIndex=0
	secondIndex=$(($numberLength -1))
	firstCompare=""
	secondCompare=""

	while  "$isPalindrome"  && [ "$count" -le "$iterate" ];do

	firstCompare=${number:$firstIndex:1}
	secondCompare=${number:$secondIndex:1}

	if [ "$firstCompare" = "$secondCompare" ];then

		firstIndex=$(($firstIndex + 1))
		secondIndex=$(($secondIndex - 1))
		count=$(($count + 1))


	else

	     isPalindrome=false
    fi

	done

	echo $isPalindrome
}

countLines () {
	echo "Ingrese el path de un archivo para saber cuantas lineas tiene"

	read path

	lines=$( wc -l < "$path" )

	echo $lines
}

orderArray () {

	echo "Ingrese una lista de numero para que obtener la misma de manera ordenada"

	read -a arrayToOrder

	arrayLegth=${#arrayToOrder[*]}

	for ((i = 0; i<$arrayLegth; i++)) 
	do
      
    for((j = 0; j<$arrayLegth-i-1; j++)) 
    do
      
        if [ ${arrayToOrder[j]} -gt ${arrayToOrder[$((j+1))]} ] 
        then
             
            temp=${arrayToOrder[j]} 
            arrayToOrder[$j]=${arrayToOrder[$((j+1))]}   
            arrayToOrder[$((j+1))]=$temp 
        fi
    done
done

echo ${arrayToOrder[*]}

}

getNumberOfFiles () {

	echo "Ingrese el directorio que desea analizar"

	#read fileToCheck

	listOfFiles=""

	ls c:\  

	echo $listOfFiles

}

goodbye () {
	echo "Adios"
	exit 0
}

main 




