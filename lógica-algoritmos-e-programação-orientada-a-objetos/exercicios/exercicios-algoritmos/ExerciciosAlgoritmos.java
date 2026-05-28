package exercicios;

import java.util.Scanner;

/**
 * Biblioteca de Algoritmos Clássicos
 * Demonstra recursividade, loops complexos, lógica de vetores e Strings.
 */
public class ExerciciosAlgoritmos {

    // 1. Fibonacci
    public static void exibirFibonacci(int n) {
        if (n <= 0) {
            System.out.println("❌ Digite um valor maior que zero.");
            return;
        }
        System.out.print("👉 Sequência de Fibonacci (" + n + " termos): ");
        long anterior = 0, atual = 1;
        for (int i = 1; i <= n; i++) {
            System.out.print(anterior + " ");
            long proximo = anterior + atual;
            anterior = atual;
            atual = proximo;
        }
        System.out.println();
    }

    // 2. Número Primo
    public static boolean verificarPrimo(int n) {
        if (n <= 1) return false;
        for (int i = 2; i <= Math.sqrt(n); i++) {
            if (n % i == 0) return false;
        }
        return true;
    }

    // 3. Fatorial Recursivo
    public static long calcularFatorial(int n) {
        if (n < 0) throw new IllegalArgumentException("Fatorial de número negativo não existe.");
        if (n == 0 || n == 1) return 1;
        return n * calcularFatorial(n - 1);
    }

    // 4. Palíndromo (ex: "arara", "radar")
    public static boolean verificarPalindromo(String texto) {
        String limpo = texto.replaceAll("[^a-zA-Z0-9]", "").toLowerCase();
        int i = 0;
        int j = limpo.length() - 1;
        while (i < j) {
            if (limpo.charAt(i) != limpo.charAt(j)) {
                return false;
            }
            i++;
            j--;
        }
        return true;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("🧠 CONJUNTO DE EXERCÍCIOS DE ALGORITMOS 🧠");

        boolean executando = true;
        while (executando) {
            System.out.println("\nSelecione o algoritmo para executar:");
            System.out.println("1. Exibir Sequência de Fibonacci");
            System.out.println("2. Verificar se um número é Primo");
            System.out.println("3. Calcular Fatorial (Recursivo)");
            System.out.println("4. Verificar se uma palavra é Palíndromo");
            System.out.println("5. Sair");
            System.out.print("Opção: ");

            try {
                String input = scanner.nextLine().trim();
                int opcao = Integer.parseInt(input);

                switch (opcao) {
                    case 1:
                        System.out.print("Quantos termos do Fibonacci deseja exibir? ");
                        int termos = Integer.parseInt(scanner.nextLine().trim());
                        exibirFibonacci(termos);
                        break;
                    case 2:
                        System.out.print("Digite o número para verificar se é primo: ");
                        int numPrimo = Integer.parseInt(scanner.nextLine().trim());
                        boolean ehPrimo = verificarPrimo(numPrimo);
                        System.out.println(ehPrimo ? "🟢 O número " + numPrimo + " é PRIMO!" : "🔴 O número " + numPrimo + " NÃO é primo.");
                        break;
                    case 3:
                        System.out.print("Digite o número para calcular o fatorial: ");
                        int numFat = Integer.parseInt(scanner.nextLine().trim());
                        long fat = calcularFatorial(numFat);
                        System.out.println("👉 " + numFat + "! = " + fat);
                        break;
                    case 4:
                        System.out.print("Digite a palavra ou frase: ");
                        String frase = scanner.nextLine().trim();
                        boolean ehPalindromo = verificarPalindromo(frase);
                        System.out.println(ehPalindromo ? "🟢 É um Palíndromo!" : "🔴 Não é um Palíndromo.");
                        break;
                    case 5:
                        executando = false;
                        System.out.println("Fechando a biblioteca de algoritmos. 👋");
                        break;
                    default:
                        System.out.println("❌ Opção inválida!");
                }
            } catch (NumberFormatException e) {
                System.out.println("❌ Erro: Digite apenas números inteiros.");
            } catch (IllegalArgumentException e) {
                System.out.println("❌ Erro: " + e.getMessage());
            } catch (Exception e) {
                System.out.println("❌ Erro inesperado: " + e.getMessage());
            }
        }
        scanner.close();
    }
}
