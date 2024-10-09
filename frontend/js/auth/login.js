async function authenticate(){
    let email = document.getElementById("email").value;
    let password = document.getElementById("password").value;

    if (email.trim() == "" || password.trim() == ""){
        Swal.fire({
            title: "¡Atención!",
            text: "Debes digitar todos los campos.",
            icon: "warning",
            confirmButtonColor: "#3085d6",
            confirmButtonText: 'Vale'
        });
    } 

    const options = {
        method: "POST",
        body: JSON.stringify({
            email: email,
            password: password
        }),
        headers: {
            'Content-Type': 'application/json'
        }
    };

    const response = await fetch("http://127.0.0.1:5000/auth/login", options);
    
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
        sessionStorage.setItem("access_token", resp.data.access_token);
        sessionStorage.setItem("refresh_token", resp.data.refresh_token);
        window.location.href = "../../pages/auth/manage.html";
    }
}