package exercicios;

import java.util.Random;
import java.util.Scanner;

/**
 * Coletânea de Mini-Projetos Utilitários
 * Reúne ferramentas como gerador de senhas aleatórias e conversores numéricos em uma única interface.
 */
public class MiniProjetos {

    // 1. Gerador de Senhas
    public static String gerarSenha(int comprimento, boolean incluirEspeciais) {
        String maiusculas = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String minusculas = "abcdefghijklmnopqrstuvwxyz";
        String numeros = "0123456789";
        String especiais = "!@#$%^&*()-_=+[]{}|;:,.<>?";

        StringBuilder caracteresValidos = new StringBuilder(maiusculas + minusculas + numeros);
        if (incluirEspeciais) {
            caracteresValidos.append(especiais);
        }

        Random random = new Random();
        StringBuilder senha = new StringBuilder();
        for (int i = 0; i < comprimento; i++) {
            int index = random.nextInt(caracteresValidos.length());
            senha.append(caracteresValidos.charAt(index));
        }
        return senha.toString();
    }

    // 2. Conversor de Decimal para Binário e Hexadecimal
    public static void converterBase(int decimal) {
        if (decimal < 0) {
            System.out.println("❌ Por favor, digite um número inteiro positivo.");
            return;
        }
        String binario = Integer.toBinaryString(decimal);
        String hexadecimal = Integer.toHexString(decimal).toUpperCase();

        System.out.println("\n---------------------------------");
        System.out.println("Resultados da Conversão para o Decimal " + decimal + ":");
        System.out.println("👉 Binário    : " + binario);
        System.out.println("👉 Hexadecimal: " + hexadecimal);
        System.out.println("---------------------------------");
    }

    // 3. Calculador de Idade em Dias
    public static int calcularIdadeEmDias(int anos, int meses, int dias) {
        // Expressando a idade apenas em dias considerando 1 ano = 365 dias e 1 mês = 30 dias
        return (anos * 365) + (meses * 30) + dias;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("🛠️ MINI-PROJETOS UTILITÁRIOS 🛠️");

        boolean ativo = true;
        while (ativo) {
            System.out.println("\nSelecione um Mini-Projeto:");
            System.out.println("1. Gerador de Senhas Aleatórias");
            System.out.println("2. Conversor de Bases Numéricas");
            System.out.println("3. Calcular Idade Expressa em Dias");
            System.out.println("4. Sair");
            System.out.print("Sua opção: ");

            try {
                String input = scanner.nextLine().trim();
                int opcao = Integer.parseInt(input);

                switch (opcao) {
                    case 1:
                        System.out.print("Comprimento da senha (min 6, max 30): ");
                        int comp = Integer.parseInt(scanner.nextLine().trim());
                        if (comp < 6 || comp > 30) {
                            System.out.println("❌ Tamanho inválido!");
                            break;
                        }
                        System.out.print("Incluir caracteres especiais? (S/N): ");
                        boolean esp = scanner.nextLine().trim().equalsIgnoreCase("S");
                        
                        String senhaGerada = gerarSenha(comp, esp);
                        System.out.println("\n🔑 Senha Gerada: " + senhaGerada);
                        break;
                    case 2:
                        System.out.print("Digite um número em base decimal: ");
                        int dec = Integer.parseInt(scanner.nextLine().trim());
                        converterBase(dec);
                        break;
                    case 3:
                        System.out.println("Informe sua idade em Anos, Meses e Dias:");
                        System.out.print("Anos: ");
                        int anos = Integer.parseInt(scanner.nextLine().trim());
                        System.out.print("Meses: ");
                        int meses = Integer.parseInt(scanner.nextLine().trim());
                        System.out.print("Dias: ");
                        int dias = Integer.parseInt(scanner.nextLine().trim());

                        if (anos < 0 || meses < 0 || dias < 0 || meses > 12 || dias > 31) {
                            System.out.println("❌ Valores de idade inválidos.");
                        } else {
                            int totalDias = calcularIdadeEmDias(anos, meses, dias);
                            System.out.println("\n👉 Sua idade em dias é aproximadamente: " + totalDias + " dias!");
                        }
                        break;
                    case 4:
                        ativo = false;
                        System.out.println("Fechando utilitários. 👋");
                        break;
                    default:
                        System.out.println("❌ Opção inválida!");
                }
            } catch (NumberFormatException e) {
                System.out.println("❌ Erro de formato! Digite apenas números inteiros.");
            } catch (Exception e) {
                System.out.println("❌ Erro: " + e.getMessage());
            }
        }
        scanner.close();
    }
}
