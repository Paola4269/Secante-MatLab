function secante()
    
    x0 = input('Ingrese el primer valor inicial (x0): ');
    x1 = input('Ingrese el segundo valor inicial (x1): ');
    max_iter = input('Ingrese el número máximo de iteraciones: ');
    tol = input('Ingrese el error porcentual tolerable: ');

    % Definir la función
    % Ingresar ecuación a calcular raíz
    f = @(x) x.^3 + 2.*x.^2 + 10.*x - 20; % Si el valor es 3x^3 ingresarlo como "3.*x.^3" 

    iter = 0;
    error = inf;
    results = [];
    
    % Cabecera tabla
    fprintf('Iter\t\tx0\t\t\tx1\t\t\tx2\t\t\tError\n');
    fprintf('----------------------------------------------------------\n');
    
    % Método
    while error > tol && iter < max_iter
        % Cálculo del siguiente punto
        x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0));
        
        % Error
        if iter > 0
            error = abs((x2 - x1) / x2) * 100;
        end
        
        % Almacenar resultados
        results = [results; iter, x0, x1, x2, error];
        
        % Mostrar resultados
        fprintf('%d\t\t%.6f\t%.6f\t%.6f\t%.6f\n', iter, x0, x1, x2, error);
        
        % Preparar para la siguiente iteración
        x0 = x1;
        x1 = x2;
        iter = iter + 1;
    end
    
    % Tabla
    disp('Resultados en forma de tabla:');
    T = array2table(results, 'VariableNames', {'Iter', 'x0', 'x1', 'x2', 'Error'});
    disp(T);
    
    % Gráfica
    figure;
    fplot(f, [min(results(:, 2:4), [], 'all'), max(results(:, 2:4), [], 'all')]);
    hold on;
    plot(results(:, 4), f(results(:, 4)), 'ro');
    
    % Añadir líneas del plano cartesiano
    xline(0, '--k'); % x
    yline(0, '--k'); % y
    
    xlabel('x');
    ylabel('f(x)');
    title('Método de la Secante');
    legend('f(x)', 'Aproximaciones de la raíz', 'Location', 'best');
    grid on;
end
