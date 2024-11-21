FROM refinedev/node:18 AS base

FROM base as deps

COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml* .npmrc* ./

RUN echo -f yarn.lock

RUN \
  if [ -f yarn.lock ]; then yarn install; \
  elif [ -f package-lock.json ]; then npm ci; \
  elif [ -f pnpm-lock.yaml ]; then yarn global add pnpm && pnpm i --frozen-lockfile; \
  else echo "Lockfile not found." && exit 1; \
  fi

FROM base as builder

ENV NODE_ENV production

COPY --from=deps /app/refine/node_modules ./node_modules

COPY . .

RUN yarn build

FROM nginx:1.21.3-alpine as runner

ENV NODE_ENV production

COPY --from=builder /app/refine/deploy/nginx/nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /app/refine/dist /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]