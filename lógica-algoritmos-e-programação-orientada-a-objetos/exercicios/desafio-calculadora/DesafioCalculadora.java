package exercicios;

import java.util.Scanner;

/**
 * Desafio Calculadora (Avançada)
 * Implementa operações matemáticas avançadas (potência, raiz, fatorial) e registrador de memória (M+, M-, MR, MC).
 */
public class DesafioCalculadora {

    private double memoria = 0.0;

    public static double calcularFatorial(int n) {
        if (n < 0) {
            throw new IllegalArgumentException("Não existe fatorial de número negativo.");
        }
        double fat = 1;
        for (int i = 2; i <= n; i++) {
            fat *= i;
        }
        return fat;
    }

    public static double calcularPotencia(double base, double expoente) {
        return Math.pow(base, expoente);
    }

    public static double calcularRaizQuadrada(double n) {
        if (n < 0) {
            throw new ArithmeticException("Erro: Não é possível calcular a raiz quadrada de um número negativo no conjunto dos reais.");
        }
        return Math.sqrt(n);
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        DesafioCalculadora calc = new DesafioCalculadora();
        System.out.println("🚀 DESAFIO CALCULADORA AVANÇADA 🚀");

        boolean rodando = true;
        while (rodando) {
            System.out.println("\n--- MEMÓRIA ATUAL: " + calc.memoria + " ---");
            System.out.println("Escolha a Operação:");
            System.out.println("1. Potência (Base ^ Expoente)");
            System.out.println("2. Raiz Quadrada (√x)");
            System.out.println("3. Fatorial (n!)");
            System.out.println("4. Adicionar valor atual à Memória (M+)");
            System.out.println("5. Subtrair valor atual da Memória (M-)");
            System.out.println("6. Limpar Memória (MC)");
            System.out.println("7. Recuperar Valor da Memória (MR)");
            System.out.println("8. Operações Básicas (+, -, *, /)");
            System.out.println("9. Sair");
            System.out.print("Sua escolha: ");

            try {
                String input = scanner.nextLine().trim();
                int opcao = Integer.parseInt(input);

                switch (opcao) {
                    case 1:
                        System.out.print("Digite a base: ");
                        double base = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));
                        System.out.print("Digite o expoente: ");
                        double exp = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));
                        double resPot = calcularPotencia(base, exp);
                        System.out.printf("👉 %.2f ^ %.2f = %.4f\n", base, exp, resPot);
                        break;
                    case 2:
                        System.out.print("Digite o número: ");
                        double numRaiz = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));
                        double resRaiz = calcularRaizQuadrada(numRaiz);
                        System.out.printf("👉 √%.2f = %.4f\n", numRaiz, resRaiz);
                        break;
                    case 3:
                        System.out.print("Digite um número inteiro: ");
                        int numFat = Integer.parseInt(scanner.nextLine().trim());
                        double resFat = calcularFatorial(numFat);
                        System.out.printf("👉 %d! = %.0f\n", numFat, resFat);
                        break;
                    case 4:
                        System.out.print("Valor para somar na memória: ");
                        double vSoma = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));
                        calc.memoria += vSoma;
                        System.out.println("✅ Memória atualizada.");
                        break;
                    case 5:
                        System.out.print("Valor para subtrair na memória: ");
                        double vSub = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));
                        calc.memoria -= vSub;
                        System.out.println("✅ Memória atualizada.");
                        break;
                    case 6:
                        calc.memoria = 0.0;
                        System.out.println("✅ Memória Limpa (MC).");
                        break;
                    case 7:
                        System.out.println("👉 Valor recuperado da memória: " + calc.memoria);
                        break;
                    case 8:
                        System.out.print("Digite a expressão básica (Ex: 5 + 3 ou 8 / 2): ");
                        String expBasica = scanner.nextLine().trim();
                        String[] partes = expBasica.split(" ");
                        if (partes.length == 3) {
                            double n1 = Double.parseDouble(partes[0].replace(",", "."));
                            String op = partes[1];
                            double n2 = Double.parseDouble(partes[2].replace(",", "."));
                            double res = 0;
                            boolean ok = true;
                            if (op.equals("+")) res = n1 + n2;
                            else if (op.equals("-")) res = n1 - n2;
                            else if (op.equals("*")) res = n1 * n2;
                            else if (op.equals("/")) {
                                if (n2 == 0) {
                                    System.out.println("❌ Divisão por zero!");
                                    ok = false;
                                } else {
                                    res = n1 / n2;
                                }
                            } else {
                                System.out.println("❌ Operador inválido!");
                                ok = false;
                            }
                            if (ok) {
                                System.out.printf("👉 Resultado: %.2f\n", res);
                            }
                        } else {
                            System.out.println("❌ Formato incorreto! Use: Número [espaço] Operador [espaço] Número");
                        }
                        break;
                    case 9:
                        rodando = false;
                        System.out.println("Fechando Calculadora Avançada. 👋");
                        break;
                    default:
                        System.out.println("❌ Opção inválida.");
                }
            } catch (NumberFormatException e) {
                System.out.println("❌ Digite números válidos.");
            } catch (ArithmeticException | IllegalArgumentException e) {
                System.out.println("❌ " + e.getMessage());
            } catch (Exception e) {
                System.out.println("❌ Erro: " + e.getMessage());
            }
        }
        scanner.close();
    }
}
