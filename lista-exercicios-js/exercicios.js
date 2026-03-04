/* 
1. Escreva um programa que declare duas variáveis numéricas e realize as quatro 
operações matemáticas básicas (+, -, *, /). Imprima os resultados no console. 
*/
console.log("--- Exercício 1 ---");
let num1 = 10;
let num2 = 5;
console.log("Soma:", num1 + num2);
console.log("Subtração:", num1 - num2);
console.log("Multiplicação:", num1 * num2);
console.log("Divisão:", num1 / num2);

/*
2. Faça um programa que mostre os números impares em um intervalo de 0 a 100.
*/
console.log("\n--- Exercício 2 ---");
let impares = [];
for (let i = 0; i <= 100; i++) {
    if (i % 2 !== 0) {
        impares.push(i);
    }
}
console.log(impares.join(", "));

/*
3. Faça um programa que mostre a quantidade de caracteres para o texto “Disciplina de 
Programação para web”.
*/
console.log("\n--- Exercício 3 ---");
let textoEx3 = "Disciplina de Programação para web";
console.log(`O texto "${textoEx3}" tem ${textoEx3.length} caracteres.`);

/*
4. Faça um programa que recebe o nome de uma variável e mostre o 
<<primeiro>>.<<último nome>>@facens.br
*/
console.log("\n--- Exercício 4 ---");
let nomeEx4 = "Edson Martin Feitosa";
let partesNome = nomeEx4.toLowerCase().split(" ");
let primeiroNome = partesNome[0];
let ultimoNome = partesNome[partesNome.length - 1];
let emailFacens = `${primeiroNome}.${ultimoNome}@facens.br`;
console.log(`Nome: "${nomeEx4}" -> ${emailFacens}`);

/*
5. Escreva um programa que imprima os números de 1 a 10 no console usando um loop. 
Os número devem ser separados com um traço, ex.: 1 – 2 – 3 - ... – 10.
*/
console.log("\n--- Exercício 5 ---");
let stringEx5 = "";
for (let i = 1; i <= 10; i++) {
    stringEx5 += i;
    if (i < 10) {
        stringEx5 += " - ";
    }
}
console.log(stringEx5);

/*
6. Faça uma função que mostre o dobro do número passado. Caso o número seja menor 
ou igual a zero deve mostrar a mensagem “Só é aceito números positivos maiores que zero”.
*/
console.log("\n--- Exercício 6 ---");
function dobro(num) {
    if (num <= 0) {
        console.log("Só é aceito números positivos maiores que zero");
    } else {
        console.log(num * 2);
    }
}
dobro(5);
dobro(0);

/*
7. Escreva uma função que receba uma string como argumento e retorne a string invertida.
*/
console.log("\n--- Exercício 7 ---");
function inverteString(str) {
    return str.split("").reverse().join("");
}
console.log("Inverter 'Javascript':", inverteString("Javascript"));

/*
8. Escreva uma função que recebe uma string como argumento e retorna o número de 
vogais presentes nessa string. Considere apenas vogais minúsculas (a, e, i, o, u).
*/
console.log("\n--- Exercício 8 ---");
function contaVogais(str) {
    let vogais = ['a', 'e', 'i', 'o', 'u'];
    let cont = 0;
    for (let char of str) {
        if (vogais.includes(char)) {
            cont++;
        }
    }
    return cont;
}
console.log("A string 'Disciplina de Programação' tem", contaVogais("Disciplina de Programação"), "vogais minúsculas");

/*
9. Escreva uma função que recebe um endereço de e-mail como argumento e retorna 
true se o e-mail for válido ou false caso contrário. Um e-mail válido deve conter um 
único símbolo '@' e pelo menos um ponto '.' após o '@'.
*/
console.log("\n--- Exercício 9 ---");
function validarEmail(email) {
    let partesArroba = email.split('@');
    if (partesArroba.length !== 2) return false;
    
    let dominio = partesArroba[1];
    return dominio.includes('.');
}
console.log("Email 'teste@teste.com' é válido?", validarEmail("teste@teste.com"));
console.log("Email 'testeteste.com' é válido?", validarEmail("testeteste.com"));
console.log("Email 'teste@@teste.com' é válido?", validarEmail("teste@@teste.com"));

/*
10. Escreva uma função que verifique se uma determinada string é um palíndromo (ou 
seja, pode ser lida da mesma forma tanto da esquerda para a direita quanto da direita 
para a esquerda).
Exemplo: arara
*/
console.log("\n--- Exercício 10 ---");
function isPalindromo(str) {
    let strLimpa = str.replace(/\s+/g, '').toLowerCase();
    let invertida = strLimpa.split("").reverse().join("");
    return strLimpa === invertida;
}
console.log("'arara' é palíndromo?", isPalindromo("arara"));
console.log("'Javascript' é palíndromo?", isPalindromo("Javascript"));
