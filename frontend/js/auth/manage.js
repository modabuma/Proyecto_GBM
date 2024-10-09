document.addEventListener("DOMContentLoaded", async function(){
    let filter_rest_1 = document.getElementById("filter-rest-1");
    let filter_rest_2 = document.getElementById("filter-rest-2");
    let html_1 = "<option value='0'>Elige una opción</option>";
    let html_2 = "<option value='0'>Elige una opción</option>";

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
