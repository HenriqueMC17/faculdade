//Função nomeada
function soma(a, b) {
    return a + b
}
console.log(soma(2,2,4))

//Função anônima
const subtracao = function(a, b) {
    return a - b
}
console.log(subtracao(5,2))

//Função arrow
const divisao = (a, b) => {
    if (b === 0) {
        return "Não é possível dividir por zero"
    }
    return a / b
}
console.log(divisao(3,4))

//explicando a diferença entre == e ===
let x = 10
let y = '10'
console.log(x == y) //Comparação de valor
console.log(x === y) //Comparação de valor e tipo

const multiplicacao = (a, b) => a * b //Função arrow com retorno implícito
console.log(multiplicacao(3,4))

let operacao = (a, b, operador) => operador(a, b)
console.log(operacao(3,4, divisao))