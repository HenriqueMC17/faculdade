/* 
1. Os triângulos podem ser classificados em 3 tipos quanto ao tamanho de seus
lados: Equilátero: Os três lados são iguais. Isósceles: Dois lados iguais.
Escaleno: Todos os lados são diferentes. Crie uma função que recebe os
comprimentos dos três lados de um triângulo e retorne sua classificação quanto
ao tamanho de seus lados.
*/
console.log("--- Exercício 1 ---");
function classificarTriangulo(lado1, lado2, lado3) {
    if (lado1 === lado2 && lado2 === lado3) {
        return "Equilátero";
    } else if (lado1 === lado2 || lado1 === lado3 || lado2 === lado3) {
        return "Isósceles";
    } else {
        return "Escaleno";
    }
}
console.log("Lados 3, 3, 3 ->", classificarTriangulo(3, 3, 3));
console.log("Lados 3, 4, 3 ->", classificarTriangulo(3, 4, 3));
console.log("Lados 3, 4, 5 ->", classificarTriangulo(3, 4, 5));

/*
2. Lidar com números em JavaScript pode dar muita dor de cabeça. Você já viu o
que acontece quando faz o seguinte comando no console: console.log(0.1 + 0.2);
O resultado será: 0.30000000000000004. Outra coisa importante de observar, é
o fato que o ponto é utilizado no lugar da vírgula e vice versa. Com isso, vamos
fazer um exercício simples para mostrar dinheiro sempre da forma correta.
Desenvolva uma função JavaScript para que ela receba um valor como
0.30000000000000004 e retorne R$0,30 (observe a vírgula e o ponto).
*/
console.log("\n--- Exercício 2 ---");
function formatarDinheiro(valor) {
    // toFixed(2) arredonda e fixa duas casas decimais
    // replace('.', ',') troca o ponto pela vírgula
    return `R$${valor.toFixed(2).replace('.', ',')}`;
}
console.log("0.1 + 0.2 formatado ->", formatarDinheiro(0.1 + 0.2));
console.log("Valor 0.30000000000000004 formatado ->", formatarDinheiro(0.30000000000000004));

/*
3. Elabore duas funções que recebem três parâmetros: capital inicial, taxa de juros
e tempo de aplicação. A primeira função retornará o montante da aplicação
financeira sob o regime de juros simples e a segunda retornará o valor da
aplicação sob o regime de juros compostos.
*/
console.log("\n--- Exercício 3 ---");
function jurosSimples(capital, taxa, tempo) {
    // Montante = Capital + Juros, onde Juros = Capital * taxa * tempo
    let montante = capital + (capital * taxa * tempo);
    return formatarDinheiro(montante);
}

function jurosCompostos(capital, taxa, tempo) {
    // Montante = Capital * (1 + taxa) ^ tempo
    let montante = capital * Math.pow((1 + taxa), tempo);
    return formatarDinheiro(montante);
}

console.log("Juros Simples (R$1.000, 10% a.m., 3 meses):", jurosSimples(1000, 0.10, 3));
console.log("Juros Compostos (R$1.000, 10% a.m., 3 meses):", jurosCompostos(1000, 0.10, 3));

/*
4. Crie uma função que verifica se um número inteiro passado como parâmetro é
divisível por 3 e retorne true ou false.
*/
console.log("\n--- Exercício 4 ---");
function divisivelPor3(numero) {
    // Se o resto da divisão por 3 for 0, é divisível
    return numero % 3 === 0;
}
console.log("O número 9 é divisível por 3?", divisivelPor3(9));
console.log("O número 10 é divisível por 3?", divisivelPor3(10));
console.log("O número 15 é divisível por 3?", divisivelPor3(15));

/*
5. Escreva uma função que recebe um vetor de números inteiros e mostre como
resultado qual é o menor e qual é o maior número.
*/
console.log("\n--- Exercício 5 ---");
function exibirMenorEMaior(vetor) {
    // Usando o operador spread (...) para passar os elementos do array
    // como argumentos individuais para Math.min e Math.max
    let menor = Math.min(...vetor);
    let maior = Math.max(...vetor);
    console.log(`Vetor: [${vetor.join(", ")}]`);
    console.log(`Menor número: ${menor}`);
    console.log(`Maior número: ${maior}`);
}

exibirMenorEMaior([10, 5, 20, 15, 2, 8]);
exibirMenorEMaior([100, -50, 0, 42, 999]);
