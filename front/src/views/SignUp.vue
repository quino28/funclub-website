<template>
  <div style="padding: 40px 20px 20px">
    <h1>Please type your infomations.</h1>
  </div>
  <div v-for="message in this.messages.error">
    <h1 class="error">{{ message }}</h1>
  </div>
  <div class="container">
    <div class="mb-3 row">
      <label for="name" class="col-sm-2 col-form-label">Name<span class="necessary">*</span></label>
      <div class="col-sm-10">
        <input type="text" class="form-control" id="name" v-model="this.form.name" placeholder="Name">
      </div>
    </div>
    <div class="mb-3 row">
      <label for="gender" class="col-sm-2 col-form-label">Gender<span class="necessary">*</span></label>
      <div class="col-sm-10">
        <div class="form-check form-check-inline" v-for="(value, key) in this.constants['GENDER']">
          <input type="radio" class="form-check-input" id="gender" name="gender" v-model="this.form.gender" :value="key">
          <label class="form-check-label">{{ value }}</label>
        </div>
      </div>
    </div>
    <div class="mb-3 row">
      <label for="address" class="col-sm-2 col-form-label">Address</label>
      <div class="col-sm-10">
        <input type="text" class="form-control" id="address" v-model="this.form.address" placeholder="Address">
      </div>
    </div>
    <div class="mb-3 row">
      <label for="email" class="col-sm-2 col-form-label">Email<span class="necessary">*</span></label>
      <div class="col-sm-10">
        <input type="email" class="form-control" id="email" v-model="this.form.email" placeholder="Email">
      </div>
    </div>
    <div class="mb-3 row">
      <label for="birthday" class="col-sm-2 col-form-label">Birthday</label>
      <div class="col-sm-10">
        <input type="date" class="form-control" id="birthday" v-model="this.form.birthday">
      </div>
    </div>
    <div class="mb-3 row">
      <label for="password" class="col-sm-2 col-form-label">Password<span class="necessary">*</span></label>
      <div class="col-sm-10">
        <input type="password" class="form-control" id="password" v-model="this.form.password" placeholder="Password">
      </div>
    </div>
    <div class="mb-3 row">
      <label for="password_confirm" class="col-sm-2 col-form-label">Password confirm<span class="necessary">*</span></label>
      <div class="col-sm-10">
        <input type="password" class="form-control" id="password_confirm" v-model="this.form.password_confirm" placeholder="Password again">
      </div>
    </div>
    <div class="mb-3 row">
      <label for="password" class="col-sm-2 col-form-label"></label>
      <div class="col-sm-10" style="text-align: left">
        <button class="btn btn-secondary"><router-link to="/sign_in">Back</router-link></button>
        <button class="btn btn-primary" @click="signUp">Go</button>
      </div>
    </div>
  </div>
</template>

<script>
import constants from '../assets/js/constants.js'

export default {
  data() {
    return {
      constants: constants,
      messages: {
        error: [],
      },
      form: {
        name: '',
        gender: '0',
        address: '',
        email: '',
        birthday: '',
        password: '',
        password_confirm: '',
      },
    }
  },
  created() {
    if (this.$store.state.member) {
      this.$router.push('/')
    }
  },
  methods: {
    signUp() {
      this.messages.error = []
      if (!this.checkParams()) return

      this.$axios.post('/api/sign_up', {
        form: this.form,
      })
      .then(res => {
        if (res && Object.keys(res.data).length) {
          this.$store.commit('setMember', res.data.member)
          // Actions for succeess
        }
      }).catch(err => {
        console.error(err)
        this.messages.error.push('Something is wrong.')
      })
    },
    checkParams() {
      Object.keys(this.form).forEach(key => {
        if ((key !== 'address' || key !== 'birthday') && this.form[key] === '') {
          this.messages.error.push(`${key} is required.`)
        }
      })
      const regex = /^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d]{8,100}$/
      if (!this.form.password || !regex.test(this.form.password)) {
        this.messages.error.push('Password must contain at least one uppercase letter, one lowercase letter and a number. And must be 8 or more characters.')
      }
      if (this.messages.error.length) {
        return false
      } else {
        return true
      }
    },
  },
}
</script>

<style lang="scss">
.container {
  padding: 20px 20px;
  .necessary {
    color: #DD4C70;
  }
  .mb-3, .row {
    button {
      margin: 0.25rem 0.125rem;
    }
    .col-sm-10 {
      text-align: left;
    }
    .form-check-inline {
      vertical-align: sub;
      label {
        vertical-align: inherit;
      }
    }
  }
}
.error {
  color: #DD4C70;
}
</style>
