module.exports = ({ env }) => ({
  host: env('HOST', '0.0.0.0'),
  port: env.int('PORT', 1337),
  url: env('SERVER_URL', ''),
  admin: {
    auth: {
      secret: env('ADMIN_JWT_SECRET', 'b70948ff8dc22013cc369d1ffafa7d58'),
    },
  },
});
