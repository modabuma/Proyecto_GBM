async function createUser(){
    let email = document.getElementById("filter-email").value;
    let password = document.getElementById("filter-password").value;
    let confirm_password = document.getElementById("filter-confirm-password").value;
    let names = document.getElementById("filter-names").value;
    let last_names = document.getElementById("filter-lastnames").value;
    let role = document.getElementById("filter-country").value;

    if (email.trim() == "" || password.trim() == "" || confirm_password.trim() == "" || names.trim() == "" || last_names.trim() == "" || role == "0"){
        Swal.fire({
            title: "¡Atención!",
            text: "Debes digitar todos los campos.",
            icon: "warning",
            confirmButtonColor: "#3085d6",
            confirmButtonText: 'Vale'
        });
    } 
    else if (password != confirm_password){
        Swal.fire({
            title: "¡Atención!",
            text: "Las contraseñas no coinciden.",
            icon: "warning",
            confirmButtonColor: "#3085d6",
            confirmButtonText: 'Vale'
        });

        loader.style.display = "none";
    }
    else
    {
        const options = {
            method: "POST",
            body: JSON.stringify({
                email: email,
                password: password,
                name : names,
                last_name : last_names,
                role : role
            }),
            headers: {
                'Content-Type': 'application/json'
            }
        };
        
        const response = await fetch("http://127.0.0.1:5000/auth/register", options);
        
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
                title: "¡Registro exítoso!",
                text: "Usuario registrado correctamente.",
                icon: "success",
                confirmButtonColor: "#3085d6",
                confirmButtonText: 'Vale'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = "../../pages/auth/login.html";
                } else {
                    window.location.href = "../../pages/auth/login.html";
                }
            });;
        }
    }
    
}

