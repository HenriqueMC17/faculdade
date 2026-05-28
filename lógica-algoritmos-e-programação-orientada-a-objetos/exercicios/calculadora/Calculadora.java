package exercicios;

import java.util.Scanner;

/**
 * Calculadora Interativa
 * Demonstra controle de fluxo (loops, switch-case) e tratamento de erros (divisão por zero, tipos de entrada).
 */
public class Calculadora {

    public static double somar(double a, double b) { return a + b; }
    public static double subtrair(double a, double b) { return a - b; }
    public static double multiplicar(double a, double b) { return a * b; }
    public static double dividir(double a, double b) {
        if (b == 0) {
            throw new ArithmeticException("Erro: Divisão por zero não é permitida!");
        }
        return a / b;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("🧮 BEM-VINDO À CALCULADORA JAVA 🧮");

        boolean ativo = true;
        while (ativo) {
            System.out.println("\nEscolha a operação:");
            System.out.println("1. Soma (+)");
            System.out.println("2. Subtração (-)");
            System.out.println("3. Multiplicação (*)");
            System.out.println("4. Divisão (/)");
            System.out.println("5. Sair");
            System.out.print("Sua opção: ");

            try {
                String input = scanner.nextLine().trim();
                int opcao = Integer.parseInt(input);

                if (opcao == 5) {
                    ativo = false;
                    System.out.println("Desligando a calculadora. Até mais! 👋");
                    break;
                }

                if (opcao < 1 || opcao > 4) {
                    System.out.println("❌ Opção inválida. Escolha um número de 1 a 5.");
                    continue;
                }

                System.out.print("Digite o primeiro número: ");
                double num1 = Double.parseDouble(scanner.nextLine().trim());

                System.out.print("Digite o segundo número: ");
                double num2 = Double.parseDouble(scanner.nextLine().trim());

                double resultado = 0;
                switch (opcao) {
                    case 1:
                        resultado = somar(num1, num2);
                        System.out.printf("👉 Resultado: %.4f + %.4f = %.4f\n", num1, num2, resultado);
                        break;
                    case 2:
                        resultado = subtrair(num1, num2);
                        System.out.printf("👉 Resultado: %.4f - %.4f = %.4f\n", num1, num2, resultado);
                        break;
                    case 3:
                        resultado = multiplicar(num1, num2);
                        System.out.printf("👉 Resultado: %.4f * %.4f = %.4f\n", num1, num2, resultado);
                        break;
                    case 4:
                        resultado = dividir(num1, num2);
                        System.out.printf("👉 Resultado: %.4f / %.4f = %.4f\n", num1, num2, resultado);
                        break;
                }
            } catch (NumberFormatException e) {
                System.out.println("❌ Entrada inválida! Digite apenas valores numéricos.");
            } catch (ArithmeticException e) {
                System.out.println("❌ " + e.getMessage());
            } catch (Exception e) {
                System.out.println("❌ Ocorreu um erro inesperado: " + e.getMessage());
            }
        }
        scanner.close();
    }
}
