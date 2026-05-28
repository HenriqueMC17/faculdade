package calculadora_simples;

import java.util.Scanner;

public class CalculadoraSimples {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("🧮 CALCULADORA SIMPLES");

        try {
            System.out.print("Digite o primeiro número: ");
            double n1 = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));

            System.out.print("Digite a operação (+, -, *, /): ");
            String op = scanner.nextLine().trim();

            System.out.print("Digite o segundo número: ");
            double n2 = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));

            double resultado = 0;
            boolean operacaoValida = true;

            switch (op) {
                case "+":
                    resultado = n1 + n2;
                    break;
                case "-":
                    resultado = n1 - n2;
                    break;
                case "*":
                    resultado = n1 * n2;
                    break;
                case "/":
                    if (n2 == 0) {
                        System.out.println("❌ Erro: Divisão por zero!");
                        operacaoValida = false;
                    } else {
                        resultado = n1 / n2;
                    }
                    break;
                default:
                    System.out.println("❌ Operador inválido!");
                    operacaoValida = false;
            }

            if (operacaoValida) {
                System.out.printf("👉 Resultado: %.2f %s %.2f = %.2f\n", n1, op, n2, resultado);
            }
        } catch (NumberFormatException e) {
            System.out.println("❌ Entrada inválida! Digite números válidos.");
        } finally {
            scanner.close();
        }
    }
}
