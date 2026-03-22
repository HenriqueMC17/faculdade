const valores = [1, 2, 3, 4, 5]
console.log(valores)
valores[0] = 10
console.log(valores)
valores[5] = 6
console.log(valores)
valores[6] = "Oi"
console.log(valores)
valores[10] = 100
console.log(valores)
console.log("Tamanho do array: " + valores.length)

//inserindo um valor no final do array
valores.push(7)
console.log(valores)
//removendo o último valor do array
valores.pop()
console.log(valores)

//inserindo um valor no início do array
valores.unshift(true)
console.log(valores)
//removendo o primeiro valor do array
valores.shift()
console.log(valores)