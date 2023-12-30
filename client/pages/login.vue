<template>
  <div class="flex flex-col h-screen justify-center bg-[url(/img/login_bg.jpg)] bg-cover bg-no-repeat">
    <div
      class="h-2/3 w-2/3 mx-auto border rounded-lg shadow-md bg-white sm:h-1/2 sm:w-1/2 lg:w-1/3"
      :class="{ 'h-2/5 sm:h-1/3': login }"
    >
      <div class="p-5 flex flex-col h-full justify-between uppercase overflow-y-auto">
        <div class="flex justify-center rounded-md text-black bg-red-600 shadow-lg shadow-stone-500">
          <button @click="login = true" class="login-button-top" :class="{ 'bg-black text-white ': login }">
            login
          </button>
          <button @click="login = false" class="login-button-top" :class="{ 'bg-black text-white ': !login }">
            register
          </button>
        </div>
        <div class="my-6">
          <form id="enterForm" action="http://localhost:3000" method="post">
            <RegisterLoginInput
              v-if="login"
              v-for="(input, i) in loginInputs"
              :input="input"
              :class="{ 'mt-4': i > 0 }"
            />
            <RegisterLoginInput
              v-else
              v-for="(input, i) in registrationInputs"
              :input="input"
              :class="{ 'mt-4': i > 0 }"
            />
          </form>
        </div>
        <div class="flex justify-center">
          <button type="submit" form="enterForm" class="login-button-base w-24 rounded-xl shadow-lg shadow-stone-500">
            entrar
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
definePageMeta({
  layout: false
});

const login = ref(true);

const email = {
  name: "Email",
  type: "email",
  minlength: 10,
  maxlength: 50
};

const id = {
  name: "C.C.",
  type: "password",
  pattern: "^[0-9]{8,10}$",
  maxlength: 10
};

const fNames = {
  name: "Nombres",
  type: "text",
  minlength: 4,
  maxlength: 30
};

const lNames = {
  name: "Apellidos",
  type: "text",
  minlength: 4,
  maxlength: 30
};

const celNum = {
  name: "Cel #: 123-456-7894",
  type: "tel",
  pattern: "\\d{3}-\\d{3}-\\d{4}",
  maxlength: 12
};

const dob = {
  name: "DOB: yyyy-mm-dd",
  type: "text",
  pattern: "\\d{4}-\\d{2}-\\d{2}",
  maxlength: 10
};

const loginInputs = [email, id];
const registrationInputs = [fNames, lNames, email, id, celNum, dob];
</script>
