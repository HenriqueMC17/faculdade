async function pesquisarCep(event) {
    event.preventDefault();
    let cep = document.querySelector('#cep').value;
    if (cep.length == 0) 
        return alert('Informe o CEP');
    cep = cep.replace('-', '').replace('.', '');
    let carregar = document.querySelector('#carregando');
    carregar.style.visibility = 'visible';
    let endereco = await consultaCEP(cep);
    document.querySelector('#rua').value = endereco.logradouro;
    document.querySelector('#bairro').value = endereco.bairro;
    document.querySelector('#estado').value = endereco.uf;
    carregar.style.visibility = 'hidden';
}

async function consultaCEP(cep) {
    //https://viacep.com.br/ws/18015066/json/
    const url = `https://viacep.com.br/ws/${cep}/json/`;
    let response = await fetch(url);
    console.log(response);
    let data = await response.json();
    console.log(data);
    return data;
}