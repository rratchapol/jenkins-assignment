const { plusHandler,server } = require('./index'); // Import your Express route handler function

describe('Plus endpoint handler', () => {
  test('returns the sum of two numbers passed in parameters', () => {
    const req = {
      params: {
        num1: '5',
        num2: '10'
      }
    };
    const res = {
      json: jest.fn()
    };

    plusHandler(req, res);

    expect(res.json).toHaveBeenCalledWith(15);
  });

  test('returns NaN if parameters are not valid numbers', () => {
    const req = {
      params: {
        num1: 'abc',
        num2: 'def'
      }
    };
    const res = {
      json: jest.fn()
    };

    plusHandler(req, res);

    expect(res.json).toHaveBeenCalledWith(NaN);
  });
});

afterAll(done => {
  server.close(done);
});