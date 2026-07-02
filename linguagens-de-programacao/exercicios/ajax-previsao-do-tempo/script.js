const resultDiv = document.getElementById('result');

document.getElementById('searchBtn').addEventListener('click', function () {
    const city = document.getElementById('cityInput').value.trim();

    if (city === '') {
        resultDiv.textContent = 'Por favor, digite uma cidade.';
        return;
    }

    resultDiv.textContent = 'Buscando...';

    const url = `https://wttr.in/${encodeURIComponent(city)}?format=3`;

    fetch(url)
        .then(response => {
            if (!response.ok) {
                throw new Error('Erro na requisição');
            }
            return response.text();
        })
        .then(data => {
            if (data.includes('<html')) {
                const parser = new DOMParser();
                const doc = parser.parseFromString(data, 'text/html');
                const termContainer = doc.querySelector('.term-container');
                resultDiv.textContent = termContainer ? termContainer.textContent.trim() : doc.body.textContent.trim();
            } else {
                resultDiv.textContent = data.trim();
            }
        })
        .catch(error => {
            resultDiv.textContent = 'Não foi possível encontrar a cidade.';
            console.error('Erro:', error);
        });
});

document.getElementById('cityInput').addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
        document.getElementById('searchBtn').click();
    }
});
