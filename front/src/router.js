import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    name: 'home',
  },
  {
    path: '/dogapi',
    name: 'dogapi',
    component: () => import('./components/DogApi.vue'),
  },
  {
    path: '/sign_in',
    name: 'signin',
    component: () => import('./components/SignIn.vue'),
  },
  {
    path: '/register',
    name: 'register',
    component: () => import('./components/Register.vue'),
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes
})
export default router
