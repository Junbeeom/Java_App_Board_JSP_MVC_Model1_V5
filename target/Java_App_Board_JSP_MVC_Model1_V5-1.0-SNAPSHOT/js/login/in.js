document.addEventListener('DOMContentLoaded', () => {
    SIGN_IN.init();
});

const SIGN_IN = {
    init: () => {
        document.getElementById('btnSignIn').addEventListener('click', (event) => {
            event.preventDefault();

            SIGN_IN.validation();
        });
    },

    validation: () => {
        let id = document.querySelector('input[name="id"]').value;
        let pw = document.querySelector('input[name="pw"]').value;

        if(COMMON.isEmpty(id.trim())) {
            alert('ID EMPTY!');
            return false;
        }

        if(COMMON.isEmpty(pw.trim())) {
            alert('PW EMPTY!');
            return false;
        }

        document.querySelector('input[name="id"]').value = hex_sha512(id);

        document.getElementById('SignIn').submit();
    }
};