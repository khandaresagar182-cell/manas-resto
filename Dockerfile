# ============================================
# NEXT.JS APP
# ============================================
# Use this for: Next.js projects
# Port: 3000
# Build: docker build -t my-nextjs-app "C:\path\to\project"
# Run:   docker run -d -p 3000:3000 --name my-nextjs-app my-nextjs-app

FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:20-alpine
WORKDIR /app
COPY --from=build /app/.next ./.next
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package.json ./package.json
COPY --from=build /app/public ./public
EXPOSE 3000
CMD ["npm", "start"]
