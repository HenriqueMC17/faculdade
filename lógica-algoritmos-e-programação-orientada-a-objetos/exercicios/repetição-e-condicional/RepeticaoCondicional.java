package exercicios;

import java.util.Scanner;

/**
 * Exercício Prático de Estruturas de Repetição e Condicional
 * Demonstra for, while, do-while, if-else e switch-case em cenários reais.
 */
public class RepeticaoCondicional {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("🔄 DEMONSTRAÇÃO DE REPETIÇÃO E CONDICIONAIS 🔄");

        boolean continuar = true;
        while (continuar) {
            System.out.println("\nSelecione um Exercício/Estrutura:");
            System.out.println("1. Estrutura 'for': Tabuada/Multiplicação rápida");
            System.out.println("2. Estrutura 'while': Jogo de Adivinhar Número");
            System.out.println("3. Estrutura 'do-while': Validador de entrada estrito");
            System.out.println("4. Condicional 'switch': Menu de Classificação de Idade");
            System.out.println("5. Sair");
            System.out.print("Escolha: ");

            try {
                String input = scanner.nextLine().trim();
                int opcao = Integer.parseInt(input);

                switch (opcao) {
                    case 1:
                        System.out.print("Deseja ver a tabuada de qual número? ");
                        int num = Integer.parseInt(scanner.nextLine().trim());
                        System.out.println("👉 Tabuada do " + num + " usando laço FOR:");
                        for (int i = 1; i <= 10; i++) {
                            System.out.println(num + " x " + i + " = " + (num * i));
                        }
                        break;
                    case 2:
                        System.out.println("👉 Jogo: Adivinhe o número secreto de 1 a 10 usando laço WHILE.");
                        int secreto = (int) (Math.random() * 10) + 1;
                        int palpite = -1;
                        int tentativas = 0;
                        while (palpite != secreto) {
                            System.out.print("Qual seu palpite? ");
                            palpite = Integer.parseInt(scanner.nextLine().trim());
                            tentativas++;
                            if (palpite < secreto) {
                                System.out.println("Tente um número MAIOR.");
                            } else if (palpite > secreto) {
                                System.out.println("Tente um número MENOR.");
                            }
                        }
                        System.out.println("🎉 Acertou com " + tentativas + " tentativa(s)! O número era " + secreto);
                        break;
                    case 3:
                        System.out.println("👉 Validador: Solicitar senha de 4 dígitos usando laço DO-WHILE.");
                        String senha;
                        do {
                            System.out.print("Defina ou digite a senha correta (deve ter 4 dígitos numéricos): ");
                            senha = scanner.nextLine().trim();
                            if (senha.length() != 4 || !senha.matches("\\d+")) {
                                System.out.println("❌ Erro: Formato inválido! Tente novamente.");
                            } else {
                                System.out.println("✅ Senha aceita e salva com sucesso!");
                                break;
                            }
                        } while (true);
                        break;
                    case 4:
                        System.out.print("Informe sua idade para classificação: ");
                        int idade = Integer.parseInt(scanner.nextLine().trim());
                        
                        // Classificação condicional traduzida para switch
                        String categoria;
                        if (idade < 0) {
                            categoria = "Inválido";
                        } else if (idade <= 12) {
                            categoria = "Criança";
                        } else if (idade <= 17) {
                            categoria = "Adolescente";
                        } else if (idade <= 60) {
                            categoria = "Adulto";
                        } else {
                            categoria = "Idoso";
                        }

                        switch (categoria) {
                            case "Criança":
                                System.out.println("🟢 Você é classificado como CRIANÇA (até 12 anos).");
                                break;
                            case "Adolescente":
                                System.out.println("🟡 Você é classificado como ADOLESCENTE (13 a 17 anos).");
                                break;
                            case "Adulto":
                                System.out.println("🔵 Você é classificado como ADULTO (18 a 60 anos).");
                                break;
                            case "Idoso":
                                System.out.println("⚪ Você é classificado como IDOSO (mais de 60 anos).");
                                break;
                            default:
                                System.out.println("❌ Idade inválida!");
                        }
                        break;
                    case 5:
                        continuar = false;
                        System.out.println("Fechando menu de repetições. 👋");
                        break;
                    default:
                        System.out.println("❌ Opção inválida!");
                }
            } catch (NumberFormatException e) {
                System.out.println("❌ Formato inválido! Insira apenas números inteiros.");
            } catch (Exception e) {
                System.out.println("❌ Erro: " + e.getMessage());
            }
        }
        scanner.close();
    }
}
