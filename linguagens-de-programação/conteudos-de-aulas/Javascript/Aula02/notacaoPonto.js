let pessoa = {}
pessoa.nome = 'Edson Martin Feitosa'
pessoa.idade = 30
console.log(pessoa)

let aluno = {
    nome: 'Maria Silva',
    idade: 25,
    curso: 'Engenharia de Software',
    endereco: {
        rua: 'Rua das Flores',
        numero: 123
    },
    notas: [8.5, 9.0, 7.5, 10.0]
}
console.log(aluno)
console.log(aluno.endereco.rua) 
console.log(aluno.notas[1])
