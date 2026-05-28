package exercicios;

import java.util.Scanner;

/**
 * Conversor de Temperatura
 * Conversões bidirecionais entre Celsius, Fahrenheit e Kelvin.
 */
public class ConversorTemperatura {

    public static double celsiusParaFahrenheit(double c) { return (c * 9/5) + 32; }
    public static double fahrenheitParaCelsius(double f) { return (f - 32) * 5/9; }
    public static double celsiusParaKelvin(double c) { return c + 273.15; }
    public static double kelvinParaCelsius(double k) { return k - 273.15; }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("🌡️ CONVERSOR DE TEMPERATURA 🌡️");

        boolean ativo = true;
        while (ativo) {
            System.out.println("\nEscolha a conversão:");
            System.out.println("1. Celsius -> Fahrenheit");
            System.out.println("2. Fahrenheit -> Celsius");
            System.out.println("3. Celsius -> Kelvin");
            System.out.println("4. Kelvin -> Celsius");
            System.out.println("5. Fahrenheit -> Kelvin");
            System.out.println("6. Kelvin -> Fahrenheit");
            System.out.println("7. Sair");
            System.out.print("Sua opção: ");

            try {
                String input = scanner.nextLine().trim();
                int opcao = Integer.parseInt(input);

                if (opcao == 7) {
                    ativo = false;
                    System.out.println("Saindo do conversor. Até logo! 👋");
                    break;
                }

                if (opcao < 1 || opcao > 6) {
                    System.out.println("❌ Opção inválida!");
                    continue;
                }

                System.out.print("Digite o valor da temperatura: ");
                double temp = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));
                double res = 0;
                String de = "", para = "";

                switch (opcao) {
                    case 1:
                        res = celsiusParaFahrenheit(temp);
                        de = "°C"; para = "°F";
                        break;
                    case 2:
                        res = fahrenheitParaCelsius(temp);
                        de = "°F"; para = "°C";
                        break;
                    case 3:
                        res = celsiusParaKelvin(temp);
                        de = "°C"; para = "K";
                        break;
                    case 4:
                        res = kelvinParaCelsius(temp);
                        de = "K"; para = "°C";
                        break;
                    case 5:
                        res = celsiusParaKelvin(fahrenheitParaCelsius(temp));
                        de = "°F"; para = "K";
                        break;
                    case 6:
                        res = celsiusParaFahrenheit(kelvinParaCelsius(temp));
                        de = "K"; para = "°F";
                        break;
                }

                System.out.printf("👉 %.2f %s equivale a %.2f %s\n", temp, de, res, para);

            } catch (NumberFormatException e) {
                System.out.println("❌ Entrada inválida! Digite apenas números.");
            } catch (Exception e) {
                System.out.println("❌ Erro: " + e.getMessage());
            }
        }
        scanner.close();
    }
}
