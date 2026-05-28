package exercicios;

import java.util.ArrayList;
import java.util.List;

/**
 * Projeto Escolar - Integração Completa de POO
 * Associações (1..1, 1..*), Encapsulamento, Construtores, Listas e Lógica de Média Acadêmica.
 */
class Professor {
    private String nome;
    private String especialidade;

    public Professor(String nome, String especialidade) {
        this.nome = nome;
        this.especialidade = especialidade;
    }

    public String getNome() { return nome; }
    public String getEspecialidade() { return especialidade; }

    @Override
    public String toString() {
        return nome + " (Especialista em " + especialidade + ")";
    }
}

class Estudante {
    private String nome;
    private String matricula;
    private double notaFinal;

    public Estudante(String nome, String matricula, double notaFinal) {
        if (notaFinal < 0 || notaFinal > 10) {
            throw new IllegalArgumentException("A nota deve ser entre 0 e 10.");
        }
        this.nome = nome;
        this.matricula = matricula;
        this.notaFinal = notaFinal;
    }

    public String getNome() { return nome; }
    public String getMatricula() { return matricula; }
    public double getNotaFinal() { return notaFinal; }

    @Override
    public String toString() {
        return String.format("Aluno: %-15s | Mat: %-6s | Nota: %4.1f", nome, matricula, notaFinal);
    }
}

class Curso {
    private String nomeCurso;
    private Professor professorResponsavel;
    private List<Estudante> estudantesMatriculados;

    public Curso(String nomeCurso, Professor professorResponsavel) {
        this.nomeCurso = nomeCurso;
        this.professorResponsavel = professorResponsavel;
        this.estudantesMatriculados = new ArrayList<>();
    }

    public void matricularEstudante(Estudante estudante) {
        estudantesMatriculados.add(estudante);
        System.out.println("🎓 Aluno " + estudante.getNome() + " matriculado no curso " + nomeCurso + ".");
    }

    public double calcularMediaCurso() {
        if (estudantesMatriculados.isEmpty()) return 0.0;
        double soma = 0;
        for (Estudante e : estudantesMatriculados) {
            soma += e.getNotaFinal();
        }
        return soma / estudantesMatriculados.size();
    }

    public void emitirRelatorio() {
        System.out.println("\n========================================");
        System.out.println("📊 RELATÓRIO DO CURSO: " + nomeCurso.toUpperCase());
        System.out.println("========================================");
        System.out.println("Docente: " + professorResponsavel);
        System.out.println("----------------------------------------");
        System.out.println("Lista de Estudantes:");
        if (estudantesMatriculados.isEmpty()) {
            System.out.println("(Nenhum aluno matriculado)");
        } else {
            for (Estudante e : estudantesMatriculados) {
                System.out.println(e);
            }
        }
        System.out.println("----------------------------------------");
        System.out.printf("Média de Desempenho do Curso: %.2f\n", calcularMediaCurso());
        System.out.println("========================================");
    }
}

public class ProjetoEscolar {
    public static void main(String[] args) {
        System.out.println("🏫 SISTEMA ACADÊMICO ESCOLAR 🏫\n");

        // Criação de Docentes
        Professor profJava = new Professor("Doutor Alan Turing", "Programação Orientada a Objetos");
        Professor profBD = new Professor("Mestre Edgar Codd", "Bancos de Dados Relacionais");

        // Criação de Cursos
        Curso cursoJava = new Curso("Desenvolvimento Java Avançado", profJava);
        Curso cursoBD = new Curso("Modelagem de Banco de Dados", profBD);

        // Matrícula de Alunos em Java
        cursoJava.matricularEstudante(new Estudante("Bob Martin", "A101", 9.5));
        cursoJava.matricularEstudante(new Estudante("Grace Hopper", "A102", 9.8));
        cursoJava.matricularEstudante(new Estudante("Ada Lovelace", "A103", 10.0));
        cursoJava.matricularEstudante(new Estudante("Linus Torvalds", "A104", 6.2));

        // Matrícula de Alunos em Banco de Dados
        cursoBD.matricularEstudante(new Estudante("Bob Martin", "A101", 8.0));
        cursoBD.matricularEstudante(new Estudante("Steve Wozniak", "A105", 7.5));

        // Emissão dos Relatórios
        cursoJava.emitirRelatorio();
        cursoBD.emitirRelatorio();
    }
}
