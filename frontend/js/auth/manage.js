document.addEventListener("DOMContentLoaded", async function(){
    let data = decodeJwt(sessionStorage.getItem("access_token"));
    let filter_rest_1 = document.getElementById("filter-rest-1");
    let filter_rest_2 = document.getElementById("filter-rest-2");
    let button_container = document.getElementById("export-button");
    let html_1 = "<option value='0'>Elige una opción</option>";
    let html_2 = "<option value='0'>Elige una opción</option>";
 
    if (data.sub.admin == 1) {
        button_container.innerHTML = "<button type='button' class='btn btn-success d-inline-block' style='margin-bottom: 30px;' onclick='exportExcel()'>Exportar registros</button>";
    }

    const options_1 = {
        method: "POST",
        body: JSON.stringify({
            role: "2"
        }),
        headers: {
            'Content-Type': 'application/json'
        }
    };

    const options_2 = {
        method: "POST",
        body: JSON.stringify({
            role: "0"
        }),
        headers: {
            'Content-Type': 'application/json'
        }
    };

    const response_1 = await fetch("http://127.0.0.1:5000/auth/getUsers", options_1);
    const response_2 = await fetch("http://127.0.0.1:5000/auth/getUsers", options_2);

    const resp_1 = await response_1.json();
    const resp_2 = await response_2.json();

    if (response_1.status != 200 && response_2.status != 200){
        Swal.fire({
            title: "¡Atención!",
            text: resp_1.message,
            icon: "error",
            confirmButtonColor: "#3085d6",
            confirmButtonText: 'Vale'
        });
    }else{
        for(i=0; i<resp_1.data.length;i++)
        {
            html_1 += "<option value='"+resp_1.data[i].id+"'>"+resp_1.data[i].name+" "+resp_1.data[i].last_name+"</option>";
        }
        filter_rest_1.innerHTML = html_1;

        for(i=0; i<resp_2.data.length;i++)
            {
                html_2 += "<option value='"+resp_2.data[i].id+"'>"+resp_2.data[i].name+" "+resp_2.data[i].last_name+"</option>";
            }
            filter_rest_2.innerHTML = html_2;
    }   
    
});

function decodeJwt(token) {

    const parts = token.split('.');
    
    if (parts.length !== 3) {
      throw new Error('Token JWT inválido');
    }
  
    const payload = atob(parts[1]);
  
    return JSON.parse(payload);
}

async function registerRest() {
    let filter_rest_1 = parseInt(document.getElementById("filter-rest-1").value, 10);
    let filter_rest_2 = parseInt(document.getElementById("filter-rest-2").value, 10);

    if (filter_rest_1 == 0){
        Swal.fire({
            title: "¡Atención!",
            text: "Debe seleccionar la persona que tomará el descanso.",
            icon: "warning",
            confirmButtonColor: "#3085d6",
            confirmButtonText: 'Vale'
        });
    }
    else if (filter_rest_2 == 0) {
        Swal.fire({
            title: "¡Atención!",
            text: "Debe seleccionar la persona que cubrirá el descanso.",
            icon: "warning",
            confirmButtonColor: "#3085d6",
            confirmButtonText: 'Vale'
        });
    }
    else {
        const options = {
            method: "POST",
            body: JSON.stringify({
                id_rest: filter_rest_1,
                id_not_rest: filter_rest_2
            }),
            headers: {
                'Content-Type': 'application/json'
            }
        };
    
        const response = await fetch("http://127.0.0.1:5000/auth/registerRest", options);
        const resp = await response.json();
    
        if (response.status != 201){
            Swal.fire({
                title: "¡Atención!",
                text: resp.message,
                icon: "error",
                confirmButtonColor: "#3085d6",
                confirmButtonText: 'Vale'
            });
        }else{
            Swal.fire({
                title: "¡Proceso exitoso!",
                text: resp.message,
                icon: "success",
                confirmButtonColor: "#3085d6",
                confirmButtonText: 'Vale'
            }).then(() => {
                location.reload();
            });
        }
    }
}

async function exportExcel() {
    const options = {
        method: "GET",
        headers: {
            'Content-Type': 'application/json'
        }
    };

    const response = await fetch("http://127.0.0.1:5000/auth/generateExcel", options);
    const resp = await response.json();
    
    if (response.status != 200){
        Swal.fire({
            title: "¡Atención!",
            text: resp.message,
            icon: "error",
            confirmButtonColor: "#3085d6",
            confirmButtonText: 'Vale'
        });
    }else{
        console.log(resp.data);
        const link = document.createElement('a');
        link.href = 'data:application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;base64,' + resp.data;
        link.download = 'registros.xlsx';
        link.click();
    }
}