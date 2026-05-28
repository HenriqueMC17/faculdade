package exercicios;

import java.util.Scanner;

/**
 * Sistema de Validação de Formando
 * Verifica se um aluno preenche todos os requisitos acadêmicos e burocráticos para a colação de grau.
 */
public class Formando {
    private String nome;
    private double mediaGlobal;
    private int horasComplementares;
    private boolean documentosEntregues;
    private boolean situacaoFinanceiraRegular;

    public Formando(String nome, double mediaGlobal, int horasComplementares, boolean documentosEntregues, boolean situacaoFinanceiraRegular) {
        if (nome == null || nome.trim().isEmpty()) {
            throw new IllegalArgumentException("O nome do formando é obrigatório.");
        }
        if (mediaGlobal < 0 || mediaGlobal > 10.0) {
            throw new IllegalArgumentException("Média global deve ser entre 0.0 e 10.0.");
        }
        if (horasComplementares < 0) {
            throw new IllegalArgumentException("Horas complementares não podem ser negativas.");
        }
        this.nome = nome;
        this.mediaGlobal = mediaGlobal;
        this.horasComplementares = horasComplementares;
        this.documentosEntregues = documentosEntregues;
        this.situacaoFinanceiraRegular = situacaoFinanceiraRegular;
    }

    public boolean aptoParaColarGrau() {
        return mediaGlobal >= 7.0 
               && horasComplementares >= 120 
               && documentosEntregues 
               && situacaoFinanceiraRegular;
    }

    public void emitirParecer() {
        System.out.println("\n========================================");
        System.out.println("🎓 PARECER ACADÊMICO - COLAÇÃO DE GRAU");
        System.out.println("========================================");
        System.out.println("Formando: " + nome);
        System.out.println("----------------------------------------");
        
        System.out.printf("Média Global (Min 7.0): %.2f - %s\n", mediaGlobal, (mediaGlobal >= 7.0 ? "✅ OK" : "❌ PENDENTE"));
        System.out.printf("Horas Complementares (Min 120): %d h - %s\n", horasComplementares, (horasComplementares >= 120 ? "✅ OK" : "❌ PENDENTE"));
        System.out.println("Documentação Acadêmica entregue: " + (documentosEntregues ? "✅ OK" : "❌ PENDENTE"));
        System.out.println("Situação Financeira com a instituição: " + (situacaoFinanceiraRegular ? "✅ OK" : "❌ PENDENTE"));
        
        System.out.println("----------------------------------------");
        if (aptoParaColarGrau()) {
            System.out.println("🟢 STATUS: APTO PARA A COLAÇÃO DE GRAU! Parabéns! 🎉");
        } else {
            System.out.println("🔴 STATUS: INAPTO. Regularize as pendências assinaladas.");
        }
        System.out.println("========================================");
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("🎓 SISTEMA DE ANÁLISE DE FORMANDO 🎓");

        try {
            System.out.print("Nome do Aluno: ");
            String nome = scanner.nextLine().trim();

            System.out.print("Média Global (Ex: 8.5): ");
            double media = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));

            System.out.print("Quantidade de Horas Complementares acumuladas: ");
            int horas = Integer.parseInt(scanner.nextLine().trim());

            System.out.print("Todos os documentos obrigatórios foram entregues? (S/N): ");
            boolean docs = scanner.nextLine().trim().equalsIgnoreCase("S");

            System.out.print("A situação financeira do aluno está regularizada? (S/N): ");
            boolean fin = scanner.nextLine().trim().equalsIgnoreCase("S");

            Formando aluno = new Formando(nome, media, horas, docs, fin);
            aluno.emitirParecer();

        } catch (NumberFormatException e) {
            System.out.println("❌ Entrada de dados inválida! Insira números nos campos de notas e horas.");
        } catch (IllegalArgumentException e) {
            System.out.println("❌ Erro de validação: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("❌ Ocorreu um erro: " + e.getMessage());
        } finally {
            scanner.close();
        }
    }
}
